package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.ProductReview;

public interface ProductReviewService {
	public void insertReview(ProductReview dto, String uploadPath) throws Exception;
	public void updateReview(ProductReview dto, String uploadPath) throws Exception;
	public void deleteReview(long num, String uploadPath) throws Exception;
	
	public List<ProductReview> getReviewList(Map<String, Object> map);
	public List<ProductReview> getReviewListByProductNum(Map<String, Object> map);
	public List<ProductReview> getMyReviewList(Map<String, Object> map);
	public int getDataCount(Map<String, Object> map);
	public int getMyReviewDataCount(long memberId);
}
