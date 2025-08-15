package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.ProductReview;

@Mapper
public interface ProductReviewMapper {
	public void insertReview(ProductReview dto) throws SQLException;
	public void updateReview(ProductReview dto) throws SQLException;
	public void deleteReview(long num) throws SQLException;
	
	public List<ProductReview> getReviewList(Map<String, Object> map);
	public List<ProductReview> getMyReviewList(Map<String, Object> map);
	public int getDataCount(Map<String, Object> map);
	public int getMyReviewDataCount(long memberId);
}
