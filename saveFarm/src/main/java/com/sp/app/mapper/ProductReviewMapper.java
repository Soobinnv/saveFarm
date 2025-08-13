package com.sp.app.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.ProductReview;

@Mapper
public interface ProductReviewMapper {
	public void insertReview(ProductReview dto, String uploadPath) throws Exception;
	public void updateReview(ProductReview dto) throws Exception;
	public void deleteReview(long num, String uploadPath) throws Exception;
	
	public List<ProductReview> getReviewList(Map<String, Object> map);
}
