package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.PackageManage;

public interface PackageManageService {
	public int dataCount(Map<String, Object> map);
	public List<PackageManage> packageList(Map<String, Object> map);
	public List<PackageManage> modalpackageList(Map<String, Object> map);
	
	public List<PackageManage> productList(long packageNum);
}
