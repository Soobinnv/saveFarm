package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Supply;


@Mapper
public interface SupplyMapper {
	public void insertSupply(Supply dto) throws SQLException;
	
	public void updateSupply(Supply dto) throws SQLException;
	public void updateState(Map<String, Object> map) throws SQLException;
	public void updateRescuedApply(Map<String, Object> map) throws SQLException;
	
	public void deleteSupply(Map<String, Object> map) throws SQLException;
	
	public List<Supply> listSupply(Map<String, Object> map);
	public int supplyListCount(Map<String, Object>map);
}
