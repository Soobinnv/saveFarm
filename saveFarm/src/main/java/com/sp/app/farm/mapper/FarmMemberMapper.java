package com.sp.app.farm.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.farm.model.Farm;

@Mapper
public interface FarmMemberMapper {
	public Farm loginMember(Map<String, Object> map);
	public void insertFarm(Farm dto) throws SQLException;
	
	public void updateFarm(Farm dto) throws SQLException;
	
	public void updateFarmName(Map<String, Object> map) throws SQLException;
	public void updateFarmerName(Map<String, Object> map) throws SQLException;
	
	public void updateStatus(Farm dto) throws SQLException;
    public void updatePassword(Farm dto) throws SQLException;
    
    public void deleteFarm(Map<String, Object> map) throws SQLException;

    public Farm findByFarmNum(Long farmNum);
    public Farm findFarmerId(Map<String, Object> map);
    public Farm findByFarmerId(String farmerId);
    public Farm findByBusinessNumber(String businessNumber);
    public int existsBusinessNumber(String businessNumber);

    public List<Farm> listFarm(Map<String, Object> map);
    public int farmCount(Map<String, Object> map);
}
