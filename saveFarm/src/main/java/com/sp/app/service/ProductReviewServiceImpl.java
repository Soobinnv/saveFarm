package com.sp.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.common.MyUtil;
import com.sp.app.mapper.ProductReviewMapper;
import com.sp.app.model.ProductReview;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ProductReviewServiceImpl implements ProductReviewService {
	private final ProductReviewMapper mapper;
	private final MyUtil myUtil;
	
	@Override
	public void insertReview(ProductReview dto, String uploadPath) throws Exception {
		try {
			mapper.insertReview(dto);
			
			// 파일 등록
			
		} catch (Exception e) {
			log.info("insertReview : ", e);
			
			throw e;
		}
	}

	@Override
	public void updateReview(ProductReview dto, String uploadPath) throws Exception {
		try {
			mapper.updateReview(dto);
			
			// 파일 수정
			
		} catch (Exception e) {
			log.info("updateReview : ", e);
			
			throw e;
		}
	}

	@Override
	public void deleteReview(long orderDetailNum, String uploadPath) throws Exception {
		try {
			mapper.deleteReview(orderDetailNum);
			
			// 파일 삭제
			
		} catch (Exception e) {
			log.info("deleteReview : ", e);
			
			throw e;
		}
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
	public List<ProductReview> getReviewListByProductNum(Map<String, Object> map) {
		List<ProductReview> list = null;
		
		try {
			list = mapper.getReviewListByProductNum(map);

			for(ProductReview dto : list) {
				dto.setReviewerName(myUtil.nameMasking(dto.getReviewerName()));
			}
			
		} catch (Exception e) {
			log.info("getReviewListByProductNum : ", e);
			
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

	@Override
	public void insertReviewLike(Map<String, Object> map) throws Exception {
		try {
			mapper.insertReviewLike(map);
			
		} catch (Exception e) {
			log.info("insertReviewLike : ", e);
			throw e;
		}
		
	}

	@Override
	public int getReviewLikeCount(long orderDetailNum) {
		int count = 0;
		
		try {
			count = mapper.getReviewLikeCount(orderDetailNum);
			
		} catch (Exception e) {
			log.info("getReviewLikeCount : ", e);
			
			throw e;
		}
		
		return count;
	}

	@Override
	public void deleteReviewLike(Map<String, Object> map) throws Exception {
		try {
			mapper.deleteReviewLike(map);
		} catch (Exception e) {
			log.info("deleteReviewLike : ", e);
			throw e;
		}
	}

	@Override
	public ProductReview findByOrderDetailNum(long orderDetailNum) {
		ProductReview list = null;
		
		try {
			list = mapper.findByOrderDetailNum(orderDetailNum);
	
			
		} catch (Exception e) {
			log.info("findByOrderDetailNum : ", e);
			
			throw e;
		}
		
		return list;
	}

	@Override
	public void updateReviewBlockStatus(long orderDetailNum, int reviewBlock) throws Exception {
		try {
			ProductReview dto = new ProductReview();
			 
			dto.setOrderDetailNum(orderDetailNum);
			dto.setReviewBlock(reviewBlock);
			
			mapper.updateReview(dto);
		} catch (Exception e) {
			log.info("updateReviewBlockStatus : ", e);
			throw e;
		}
	}

}
