package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.packageReview;

@Mapper
public interface PackageReviewMapper {
	public void insertsubReview(packageReview dto) throws SQLException;
	public void insertsubImage(packageReview dto) throws SQLException;
	public List<packageReview> listReview(Map<String, Object> map)throws SQLException;
	public int countReview() throws SQLException;
}
