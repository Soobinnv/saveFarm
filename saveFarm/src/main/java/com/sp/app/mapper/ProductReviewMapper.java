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
	public void deleteReview(long orderDetailNum) throws SQLException;
	
	public ProductReview findByOrderDetailNum(long orderDetailNum);
	
	public List<ProductReview> getReviewList(Map<String, Object> map);
	public List<ProductReview> getReviewListByProductNum(Map<String, Object> map);
	public List<ProductReview> getMyReviewList(Map<String, Object> map);
	
	public int getDataCount(Map<String, Object> map);
	public int getMyReviewDataCount(long memberId);
	public int getReviewLikeCount(long orderDetailNum);
	
	public void insertReviewLike(Map<String, Object> map) throws SQLException;
	public void deleteReviewLike(Map<String, Object> map) throws SQLException;
	
}
