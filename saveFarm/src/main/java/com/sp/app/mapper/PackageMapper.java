package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.PackageOrder;

@Mapper
public interface PackageMapper {
	public String findByMaxsubNumber(String preNumber);
	public List<PackageOrder> findByPayData() throws SQLException;
	
	public void insertsubStatus(PackageOrder dto) throws SQLException;
	public void insertsubPackage(PackageOrder dto) throws SQLException;
	public void insertsubItem(PackageOrder dto) throws SQLException;
	public void insertsubDestination(PackageOrder dto) throws SQLException;
	public void updateProductStockDec(PackageOrder dto) throws SQLException;
	
	public PackageOrder subPackageinfo(String subNum) throws SQLException;
	public PackageOrder subItemList(String subNum) throws SQLException;
	
	public List<PackageOrder> findBysubData(long memberId) throws SQLException;
	
}
