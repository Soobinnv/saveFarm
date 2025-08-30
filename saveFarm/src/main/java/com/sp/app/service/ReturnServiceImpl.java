package com.sp.app.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sp.app.mapper.ReturnMapper;
import com.sp.app.model.Return;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ReturnServiceImpl implements ReturnService {
	
	private final ReturnMapper mapper;
	private final MyPageService myPageService;
	
	@Transactional
	@Override
	public void insertReturn(Return dto, String uploadPath) throws Exception {
		try {
			// 상태 : 반품 신청
			dto.setStatus(0);
			mapper.insertReturn(dto);
			
			Map<String, Object> paramMap = new HashMap<>();
			
			paramMap.put("orderDetailNum", dto.getOrderDetailNum());
			
			// 주문 상세 상태 - 반품요청 상태로 변경
			paramMap.put("detailState", 10);
			paramMap.put("stateMemo", "반품신청");
			
			paramMap.put("memberId", dto.getMemberId());
			
			myPageService.updateOrderDetailState(paramMap);
			
		} catch (Exception e) {
			log.info("insertReturn : ", e);
			
			throw e;
		}
		
	}

	@Override
	public void updateReturn(Return dto, String uploadPath) throws Exception {
		try {
			mapper.updateReturn(dto);
		} catch (Exception e) {
			log.info("updateReturn : ", e);
			
			throw e;
		}
	}

	@Override
	public void deleteReturn(long returnNum, String uploadPath) throws Exception {
		try {
			mapper.deleteReturn(returnNum);
		} catch (Exception e) {
			log.info("deleteReturn : ", e);
			
			throw e;
		}
	}

	@Override
	public boolean deleteReturnImageFile(String uploadPath, String filename) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<Return> getReturnList(Map<String, Object> map) {
		List<Return> list = null;
		
		try {
			list = mapper.getReturnList(map);
	
			
		} catch (Exception e) {
			log.info("getReturnList : ", e);
			
			throw e;
		}
		
		return list;
	}

	@Override
	public List<Return> getMyReturnList(Map<String, Object> map) {
		List<Return> list = null;
		
		try {
			list = mapper.getMyReturnList(map);
	
			
		} catch (Exception e) {
			log.info("getMyReturnList : ", e);
			
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
	public int getMyReturnDataCount(long memberId) {
		int count = 0;
		
		try {
			count = mapper.getMyReturnDataCount(memberId);
			
		} catch (Exception e) {
			log.info("getMyReturnDataCount : ", e);
			
			throw e;
		}
		
		return count;
	}

	@Override
	public Return getReturnInfo(Map<String, Object> map) {
		Return dto = null;
		
		try {
			dto = mapper.getReturnInfo(map);
		} catch (Exception e) {
			log.info("getReturnInfo : ", e);
			
			throw e;
		}
		
		return dto;
	}

}
