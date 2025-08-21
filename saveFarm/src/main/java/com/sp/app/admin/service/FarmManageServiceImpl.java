package com.sp.app.admin.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Service;

import com.sp.app.admin.mapper.FarmManageMapper;
import com.sp.app.admin.model.FarmManage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class FarmManageServiceImpl implements FarmManageService {
	private final FarmManageMapper mapper;
	
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
	public List<FarmManage> listFarm(Map<String, Object> map) {
		List<FarmManage> list = null;
		try {
			list = mapper.listFarm(map);
		} catch (Exception e) {
			log.info("dataCount : ", e);
		}
		return list;
	}

	@Override
	public FarmManage findById(long farmNum) {
		FarmManage dto = null;
		
		try {
			dto = Objects.requireNonNull(mapper.findById(farmNum));
		} catch (Exception e) {
			log.info("findById : ", e);
		}
		
		return dto;
	}

	@Override
	public void updateFarm(FarmManage dto) throws SQLException {
		try {
			mapper.updateFarm(dto);
		} catch (Exception e) {
			log.info("updateFarm : ", e);
		}
		
	}

	@Override
	public void deleteFarm(long farmNum) throws SQLException {
		try {
			mapper.deleteFarm(farmNum);
		} catch (Exception e) {
			log.info("deleteFarm : ", e);
		}
	}

	@Override
	public void updateFarmStatus(Map<String, Object> map) throws SQLException {
		try {
			mapper.updateFarmStatus(map);
		} catch (Exception e) {
			log.info("updateFarmStatus : ", e);
						
			throw e;
		}
		
	}

	@Override
	public void insertFarmStatus(FarmManage dto) throws SQLException {
		try {
			mapper.insertFarmStatus(dto);
		} catch (Exception e) {
			log.info("insertMemberStatus : ", e);
						
			throw e;
		}
		
	}

	@Override
	public void updateFailureCountReset(long farmNum) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	
	
}
