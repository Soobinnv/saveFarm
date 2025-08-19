package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Return;

@Mapper
public interface ReturnMapper {
	public void insertReturn(Return dto) throws SQLException;
	public void updateReturn(Return dto) throws SQLException;
	public void deleteReturn(long orderDetailNum) throws SQLException;
	
	public List<Return> getReturnList(Map<String, Object> map);	
	public List<Return> getMyReturnList(Map<String, Object> map);	
	public int getDataCount(Map<String, Object> map);
	public int getMyReturnDataCount(long memberId);
}
