package com.sp.app.mapper;

import java.sql.SQLException;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.PackageOrder;

@Mapper
public interface PackageMapper {
	public String findByMaxsubNumber(String preNumber);
	public PackageOrder findByPayData() throws SQLException;
	
	public void insertsubStatus(PackageOrder dto) throws SQLException;
	public void insertsubPackage(PackageOrder dto) throws SQLException;
	public void insertsubItem(PackageOrder dto) throws SQLException;
	public void insertsubDestination(PackageOrder dto) throws SQLException;
	public void updateProductStockDec(PackageOrder dto) throws SQLException;
	
}
