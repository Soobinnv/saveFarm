package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.FarmManage;

@Mapper
public interface FarmManageMapper {
	public int dataCount(Map<String, Object> map);
	public List<FarmManage> listFarm(Map<String, Object> map);
	
	public FarmManage findById(long farmNum);
	
	public void updateFarm(FarmManage dto) throws SQLException;
	public void deleteFarm(long farmNum) throws SQLException;
	public void updateFarmStatus(Map<String, Object> map) throws SQLException;
	
	public void insertFarmStatus(FarmManage dto) throws SQLException;
	
	public void updateFailureCountReset(long farmNum) throws SQLException;
}
