package com.sp.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.model.ProductReview;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ProductReviewServiceImpl implements ProductReviewService {@Override
	public void insertReview(ProductReview dto, String uploadPath) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateReview(ProductReview dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteReview(long num, String uploadPath) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<ProductReview> getReviewList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<ProductReview> getMyReviewList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

}
