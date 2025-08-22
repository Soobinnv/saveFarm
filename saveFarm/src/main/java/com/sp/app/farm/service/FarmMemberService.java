package com.sp.app.farm.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.sp.app.farm.model.Farm;

public interface FarmMemberService {
	public Farm loginMember(Map<String, Object> map);
	
	public void insertFarm(Farm dto) throws SQLException;

	public void updateFarm(Farm dto) throws SQLException;
	// 농가 승인여부
	public void updateStatus(Farm dto, Long farmNum) throws SQLException;
	// 비밀번호 재설정
	public void updatePassword(Farm dto) throws SQLException;
	
	public void deleteFarm(Map<String, Object> map) throws SQLException;
	
	// 비번 생성
	public void generatePwd(Farm dto) throws Exception;
	
	// 농가찾기
	public Farm findByFarmNum(Long farmNum);
	// 아이디 찾기용
	public Farm findFarmerId(String businessNumber, String farmerName, String farmerTel);
	// 비번찾기
	public Farm findByFarmerId(String farmerId);
	// 중복가입 방지용
	public int existsBusinessNumber(String businessNumber);
	public Farm findByBusinessNumber (String businessNumber);
	
	// 조회용
	public List<Farm> listFindFarm(Map<String, Object> map);
	public int farmListCount(Map<String, Object> map);
}
