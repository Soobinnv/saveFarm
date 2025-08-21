package com.sp.app.mapper;

import java.sql.SQLException;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.packageReview;

@Mapper
public interface PackageReviewMapper {
	public void insertsubReview(packageReview dto) throws SQLException;
	public void insertsubImage(packageReview dto) throws SQLException;
}
