package com.sp.app.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.sp.app.model.Farm;

public interface FarmMemberService {
	public void insertFarm(Farm dto) throws SQLException;

	public void updateFarm(Farm dto) throws SQLException;
	// 농가 승인여부
	public void updateStatus(Map<String, Object> map) throws SQLException;
	// 비밀번호 재설정
	public void updatePassword(Farm dto, String farmerId) throws SQLException;
	
	public void deleteFarm(Map<String, Object> map) throws SQLException;
	
	// 농가찾기
	public Farm findByFarmNum(Long farmNum);
	// 아이디 찾기용
	public String findFarmerId(String businessNumber, String farmerName, String farmerTel);
	// 비번찾기
	public Farm findByFarmerId(String farmerId);
	// 중복가입 방지용
	public int existsBusinessNumber(String businessNumber);
	
	// 전체 조회용
	public List<Farm> listFindFarm(Map<String, Object> map);
	public int farmListCount(Map<String, Object> map);
	// 비승인 대상 조회용
	public List<Farm> listFindStatus(int status);
	public int statusListCount(int status);
	// 가입날짜 조회용
	public List<Farm> listFindRegDate(String farmRegDate);
	public int regDateListCount(String farmRegDate);
}
