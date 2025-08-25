package com.sp.app.admin.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface reportManagemapper {
	
	public int dataCount(Map<String, Object> map);
	public int dataGroupCount(Map<String, Object> map);
	
}
