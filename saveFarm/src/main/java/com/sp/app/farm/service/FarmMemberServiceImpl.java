package com.sp.app.farm.service;

import java.security.SecureRandom;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sp.app.farm.mapper.FarmMemberMapper;
import com.sp.app.farm.model.Farm;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class FarmMemberServiceImpl implements FarmMemberService {
	private final FarmMemberMapper mapper;
	
	@Override
	public Farm loginMember(Map<String, Object> map) {
		Farm dto = null;
		
		try {
			dto = mapper.loginMember(map);
		} catch (Exception e) {
			log.info("loginMember : ", e);
		}
		
		return dto;
	}
	
	@Transactional(rollbackFor = {Exception.class})
	@Override
	public void insertFarm(Farm dto) throws SQLException {
		try {
			mapper.insertFarm(dto);
		} catch (Exception e) {
			log.info("insertFarm : ", e);
			throw e;
		}
		
	}

	@Transactional(rollbackFor = {Exception.class})
	@Override
	public void updateFarm(Farm dto) throws SQLException {
		try {
			mapper.updateFarm(dto);
		} catch (Exception e) {
			log.info("updateFarm : ", e);
			throw e;
		}
		
	}

	@Transactional(rollbackFor = {Exception.class})
	@Override
	public void updateStatus(Farm dto, Long farmNum) throws SQLException {
		try {
			dto = Objects.requireNonNull(mapper.findByFarmNum(farmNum));
			mapper.updateStatus(dto);
		} catch (Exception e) {
			log.info("updateStatus : ", e);
			throw e;
		}		
	}

	@Transactional(rollbackFor = {Exception.class})
	@Override
	public void updatePassword(Farm dto) throws SQLException {
		try {
			mapper.updatePassword(dto);
		} catch (Exception e) {
			log.info("updatePassword : ", e);
			throw e;
		}
		
	}

	@Transactional(rollbackFor = {Exception.class})
	@Override
	public void deleteFarm(Map<String, Object> map) throws SQLException {
		try {
			mapper.deleteFarm(map);
		} catch (Exception e) {
			log.info("deleteFarm : ", e);
			throw e;
		}
		
	}

	@Override
	public Farm findByFarmNum(Long farmNum) {
		Farm dto = null;
		
		try {
			dto = Objects.requireNonNull(mapper.findByFarmNum(farmNum));
		} catch (Exception e) {
			log.info("findByFarmNum : ", e);
		}
		
		return dto;
	}

	@Override
	public Farm findFarmerId(String businessNumber, String farmerName, String farmerTel) {
		Farm dto = null;
		
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("businessNumber", businessNumber);
			map.put("farmerName", farmerName);
			map.put("farmerTel", farmerTel);
			
			dto = Objects.requireNonNull(mapper.findFarmerId(map));
			
		} catch (Exception e) {
			log.info("findFarmerId : ", e);
		}
		
		return dto;
	}

	@Override
	public Farm findByFarmerId(String farmerId) {
		Farm dto = null;
		
		try {
			dto = mapper.findByFarmerId(farmerId);
			if (dto == null) { 
				return null;
			}
		} catch (Exception e) {
			log.info("findByFarmerId : ", e);
		}
		
		return dto;
	}
	
	@Override
	public Farm findByBusinessNumber(String businessNumber) {
		Farm dto = null;
		
		try {
			 if (businessNumber == null || businessNumber.isBlank()) {
				 return null;
			 }
			 dto = mapper.findByBusinessNumber(businessNumber);
		} catch (Exception e) {
			log.info("findByFarmerId : ", e);
		}
		
		return dto;
	}

	@Override
	public int existsBusinessNumber(String businessNumber) {
		int exsist = 0;
		
		try {
			if(mapper.existsBusinessNumber(businessNumber) != 0) {
				exsist = 1;
			}
			
		} catch (Exception e) {
			log.info("existsBusinessNumber : ", e);
		}
		
		return exsist;
	}

	@Override
	public List<Farm> listFindFarm(Map<String, Object> map) {
		List<Farm> list = null;
		
		try {
			list = mapper.listFarm(map);
		} catch (Exception e) {
			log.info("listFindFarm : ", e);
		}
		
		return list;
	}

	@Override
	public int farmListCount(Map<String, Object> map) {
		int count = 0;
		
		try {
			if(mapper.farmCount(map) != 0 ) {
				count = mapper.farmCount(map);
			}
		} catch (Exception e) {
			log.info("farmListCount : ", e);
		}
		
		return count;
	}

	@Override
	public void generatePwd(Farm dto) throws Exception {
		// 10 자리 임시 패스워드 생성
		
		String lowercase = "abcdefghijklmnopqrstuvwxyz";
		String uppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		String digits = "0123456789";
		String special_characters = "!#@$%^&*()-_=+[]{}?";
		String all_characters = lowercase + digits + uppercase + special_characters;
		
		try {
			// 암호화적으로 안전한 난수 생성(예측 불가 난수 생성)
			SecureRandom random = new SecureRandom();
			
			StringBuilder sb = new StringBuilder();
			
			// 각 문자는 최소 하나 이상 포함
			sb.append(lowercase.charAt(random.nextInt(lowercase.length())));
			sb.append(uppercase.charAt(random.nextInt(uppercase.length())));
			sb.append(digits.charAt(random.nextInt(digits.length())));
			sb.append(special_characters.charAt(random.nextInt(special_characters.length())));
			
			for(int i = sb.length(); i < 10; i++) {
				int index = random.nextInt(all_characters.length());
				
				sb.append(all_characters.charAt(index));
			}
			
			// 문자 섞기
			StringBuilder password = new StringBuilder();
			while (sb.length() > 0) {
				int index = random.nextInt(sb.length());
				password.append(sb.charAt(index));
				sb.deleteCharAt(index);
			}
	        
			String result;
			result = dto.getFarmName() +"(농가)의 새로 발급된 임시 패스워드는 <b> "
					+ password.toString() + " </b> 입니다.<br>"
					+ "로그인 후 반드시 패스워드를 변경하시기 바랍니다.";
			
			// 테이블의 패스워드 변경
			dto.setFarmerPwd(password.toString());
			mapper.updateFarm(dto);
			
			// 암호화 필요할 경우  	
			// password를 다시 암호화 시키면 됨
			
		} catch (Exception e) {
			throw e;
		}
	}

}
