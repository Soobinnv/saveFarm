package com.sp.app.admin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.PackageManage;

@Mapper
public interface PackageManageMapper {
	public int dataCount(Map<String, Object> map);
	public List<PackageManage> packageList(Map<String, Object> map);
	public List<PackageManage> modalpackageList();
	
	public List<PackageManage> productList(long packageNum);
	
}
