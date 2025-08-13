package com.sp.app.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.sp.app.model.Supply;

public interface SupplyService {
	public void insertSupply(Supply dto) throws SQLException;
	
	public void updateSupply(Supply dto) throws SQLException;
	public void updateState(Map<String, Object> map) throws SQLException;
	public void updateRescuedApply(Map<String, Object> map) throws SQLException;
	
	public void deleteSupply(Map<String, Object> map) throws SQLException;
	
	// 전체조회용
	public List<Supply> listFindSupply(Map<String, Object> map);
	public int supplyListCount(Map<String, Object>map);
	
	// 특정 농가의 납품목록
	public List<Supply> listFindFarmSupply(Long farmNum);
	public int farmSupplyListCount(Long farmNum);
	// 특정 농산물 납품목록
	public List<Supply> listFindFarmRA(Long varietyNum);
	public int farmRAListCount(Long varietyNum);
	
	// 승인여부 대상 조회용
	public List<Supply> listFindStatus(int status);
	public int statusListCount(int status);
	// 긴급구출상품신청여부조회용
	public List<Supply> listFindRescuedApply(int rescuedApply);
	public int rescuedApplyListCount(int rescuedApply);
}
