package com.sp.app.service;


import com.sp.app.model.PackageOrder;

public interface packageService {
	public String subPackageNumber();
	public void insertPackageOrder(PackageOrder dto) throws Exception;
	public PackageOrder setMysubInfo(String subNum) throws Exception;
}
