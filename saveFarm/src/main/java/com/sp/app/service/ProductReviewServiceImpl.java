package com.sp.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.ProductReviewMapper;
import com.sp.app.model.ProductReview;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ProductReviewServiceImpl implements ProductReviewService {
	private final ProductReviewMapper mapper;
	
	@Override
	public void insertReview(ProductReview dto, String uploadPath) throws Exception {
		try {
			mapper.insertReview(dto);
			
		} catch (Exception e) {
			log.info("insertReview : ", e);
			
			throw e;
		}
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
		List<ProductReview> list = null;
		
		try {
			list = mapper.getReviewList(map);
	
			
		} catch (Exception e) {
			log.info("getReviewList : ", e);
			
			throw e;
		}
		
		return list;
	}

	@Override
	public List<ProductReview> getMyReviewList(Map<String, Object> map) {
		List<ProductReview> list = null;
		
		try {
			list = mapper.getMyReviewList(map);
	
			
		} catch (Exception e) {
			log.info("getMyReviewList : ", e);
			
			throw e;
		}
		
		return list;
	}

	@Override
	public int getDataCount(Map<String, Object> map) {
		int count = 0;
		
		try {
			count = mapper.getDataCount(map);
			
		} catch (Exception e) {
			log.info("getDataCount : ", e);
			
			throw e;
		}
		
		return count;
	}

	@Override
	public int getMyReviewDataCount(long memberId) {
		int count = 0;
		
		try {
			count = mapper.getMyReviewDataCount(memberId);
			
		} catch (Exception e) {
			log.info("getMyReviewDataCount : ", e);
			
			throw e;
		}
		
		return count;
	}

}
