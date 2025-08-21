package com.sp.app.admin.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Service;

import com.sp.app.admin.mapper.MemberManageMapper;
import com.sp.app.admin.model.MemberManage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class MemberManageServiceImpl implements MemberManageService {
	private final MemberManageMapper mapper;
	
	
	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = mapper.dataCount(map);
		} catch (Exception e) {
			log.info("dataCount : ", e);
		}
		return result;
	}

	@Override
	public List<MemberManage> listMember(Map<String, Object> map) {
		List<MemberManage> list = null;
		
		try {
			list = mapper.listMember(map);
		} catch (Exception e) {
			log.info("listMember : ", e);
		}
		
		return list;
	}

	@Override
	public MemberManage findById(Long memberId) {
		MemberManage dto = null;
		
		try {
			dto = Objects.requireNonNull(mapper.findById(memberId));
		} catch (Exception e) {
			log.info("findById : ", e);
		}
		
		return dto;
	}

	@Override
	public void updateMember(Map<String, Object> map) throws SQLException {
		
		try {
			mapper.updateMember1(map);
			mapper.updateMember2(map);
		} catch (Exception e) {
			log.info("updateMember : ", e);
		}
	}

	
	@Override
	public void deleteMember(Long memberId) throws SQLException {
		
		try {
			mapper.deleteMember(memberId);
			
		} catch (Exception e) {
			log.info("deleteMember : ", e);
		}
		
	}


	@Override
	public void updateMemberLevel(Map<String, Object> map) throws SQLException {
		try {
			mapper.updateMemberLevel(map);
		} catch (Exception e) {
			log.info("updateMemberLevel : ", e);
		}
		
	}

	@Override
	public void updateMemberEnabled(Map<String, Object> map) throws SQLException {
		try {
			mapper.updateMemberEnabled(map);
		} catch (Exception e) {
			log.info("updateMemberEnabled : ", e);
		}
		
	}


	@Override
	public void insertMemberStatus(MemberManage dto) throws SQLException {
		try {
			mapper.insertMemberStatus(dto);
		} catch (Exception e) {
			log.info("insertMemberStatus : ", e);
						
			throw e;
		}
		
	}

	@Override
	public List<MemberManage> listMemberStatus(Long memberId) {
		List<MemberManage> list = null;
		try {
			list = mapper.listMemberStatus(memberId);
		} catch (Exception e) {
			log.info("listMemberStatus : ", e);
		}
		return list;
	}

	@Override
	public MemberManage findByStatus(Long memberId) {
		MemberManage dto = null;

		try {
			dto = mapper.findByStatus(memberId);
		} catch (Exception e) {
			log.info("findByStatus : ", e);
		}

		return dto;
	}

	@Override
	public void updateFailureCountReset(Long memberId) throws SQLException {
		// TODO Auto-generated method stub
		
	}


}
