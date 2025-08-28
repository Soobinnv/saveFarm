package com.sp.app.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sp.app.mapper.RefundMapper;
import com.sp.app.model.Refund;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class RefundServiceImpl implements RefundService{
	private final RefundMapper mapper;
	private final MyPageService myPageService;
	
	@Transactional
	@Override
	public void insertRefund(Refund dto, String uploadPath) throws Exception {
		try {
			// 상태 : 환불 신청
			dto.setStatus(0);
			mapper.insertRefund(dto);
			
			Map<String, Object> paramMap = new HashMap<>();
			
			paramMap.put("orderDetailNum", dto.getOrderDetailNum());
			
			// 주문 상세 - 주문 취소 요청 상태로 변경
			paramMap.put("detailState", 4);
			paramMap.put("stateMemo", "주문취소요청");
			
			paramMap.put("memberId", dto.getMemberId());
			
			myPageService.updateOrderDetailState(paramMap);
			
		} catch (Exception e) {
			log.info("insertRefund : ", e);
			
			throw e;
		}
	}

	@Override
	public void updateRefund(Refund dto, String uploadPath) throws Exception {
		try {
			mapper.updateRefund(dto);
		} catch (Exception e) {
			log.info("updateRefund : ", e);
			
			throw e;
		}
	}

	@Override
	public void deleteRefund(long refundNum, String uploadPath) throws Exception {
		try {
			mapper.deleteRefund(refundNum);
		} catch (Exception e) {
			log.info("deleteRefund : ", e);
			
			throw e;
		}
	}

	@Override
	public boolean deleteRefundImageFile(String uploadPath, String filename) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<Refund> getRefundList(Map<String, Object> map) {
		List<Refund> list = null;
		
		try {
			list = mapper.getRefundList(map);
	
			
		} catch (Exception e) {
			log.info("getRefundList : ", e);
			
			throw e;
		}
		
		return list;
	}

	@Override
	public List<Refund> getMyRefundList(Map<String, Object> map) {
		List<Refund> list = null;
		
		try {
			list = mapper.getMyRefundList(map);
	
			
		} catch (Exception e) {
			log.info("getMyRefundList : ", e);
			
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
	public int getMyRefundDataCount(long memberId) {
		int count = 0;
		
		try {
			count = mapper.getMyRefundDataCount(memberId);
			
		} catch (Exception e) {
			log.info("getMyRefundDataCount : ", e);
			
			throw e;
		}
		
		return count;
	}

}
