package com.sp.app.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.TotalCount;

@Mapper
public interface TotalCountMapper {
	public  TotalCount getSiteTotalsAllTime();

	public TotalCount countFarm();
}
