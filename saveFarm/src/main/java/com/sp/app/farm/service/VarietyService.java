package com.sp.app.farm.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.sp.app.farm.model.Variety;

public interface VarietyService {
	public void insertVariety(Variety dto) throws SQLException;
	
	public void updateVariety(Variety dto) throws SQLException;
	
	public void deleteVariety(Map<String, Object> map) throws SQLException;
	
	// 혹시 순서 설정위해서 보고 싶을까봐 추가함
	public Variety findByVarietyNum(Long varietyNum);
	// 이름 중복여부
	public int existsVarietyName(String varietyName);
	
	public List<Variety> listAll();
	public int allCount();
	
	public List<Variety> listVariety(Map<String, Object> map);
	public int VarietyCount(Map<String, Object> map);
}
