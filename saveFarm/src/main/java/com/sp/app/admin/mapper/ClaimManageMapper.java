package com.sp.app.admin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Return;


@Mapper
public interface ClaimManageMapper {
	public List<Return> getClaimList(Map<String, Object> map);	
	public int getDataCount(Map<String, Object> map);
}
