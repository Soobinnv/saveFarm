package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Farm;

@Mapper
public interface FarmMemberMapper {
	public void insertFarm(Farm dto) throws SQLException;
	
	public void updateFarm(Farm dto) throws SQLException;
	
	public void updateFarmName(Map<String, Object> map) throws SQLException;
	public void updateFarmManager(Map<String, Object> map) throws SQLException;
	
	public void updateStatus(Map<String, Object> map) throws SQLException;
    public void updatePassword(Map<String, Object> map) throws SQLException;
    
    public void deleteFarm(Map<String, Object> map) throws SQLException;

    public Farm findByFarmNum(Long farmNum);
    public String findFarmerId(Map<String, Object> map);
    public Farm findByFarmerId(String farmerId);
    public int existsBusinessNumber(String businessNumber);

    public List<Farm> listFarm(Map<String, Object> map);
    public int farmCount(Map<String, Object> map);
}
