package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.HomeBob;

@Mapper
public interface HomeBobMapper {
	public long homeBobSeq();
	public void insertHomeBob(HomeBob dto) throws SQLException;
	public void updateHomeBob(HomeBob dto) throws SQLException;
	public void deleteHomeBob(long num) throws SQLException;
	
	public int dataCount(Map<String, Object> map);
	public List<HomeBob> listHomeBob(Map<String, Object> map);
	
	public HomeBob findById(long num);
	public HomeBob findByPrev(Map<String, Object> map);
	public HomeBob findByNext(Map<String, Object> map);

	public HomeBob findByFileId(long num);
	public List<HomeBob> listHomeBobFile(long num);
	public void insertHomeBobFile(HomeBob dto) throws SQLException;
	public void deleteHomeBobFile(Map<String, Object> map) throws SQLException;	
	
}
