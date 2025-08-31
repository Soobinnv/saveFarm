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
			paramMap.put("memberId", dto.getMemberId());
			paramMap.put("orderQuantity", dto.getOrderQuantity());
			
			int returnableQuantity = getReturnableQuantity(paramMap);
			
			// 반품가능 수량 = 반품 요청 수량
			if(returnableQuantity == dto.getQuantity()) {
				// 주문 상세 상태 - 반품요청 상태로 변경
				paramMap.put("detailState", 10);
				paramMap.put("stateMemo", "반품요청");
			} else {
				paramMap.put("detailState", 16);
				paramMap.put("stateMemo", "부분반품요청");				
			}
			
			myPageService.updateOrderDetailState(paramMap);
			
		} catch (Exception e) {
			log.info("insertReturn : ", e);
			
			throw e;
		}
		
	}

	@Transactional
	@Override
	public void updateReturn(Return dto, String uploadPath) throws Exception {
		try {
			mapper.updateReturn(dto);
			
			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("orderDetailNum", dto.getOrderDetailNum());
			paramMap.put("memberId", dto.getMemberId());
			
			int status = dto.getStatus();
			
			switch (status) {
				// 반품 접수
				case 1: {
					paramMap.put("detailState", 11);
					paramMap.put("stateMemo", "반품접수");
					break;
				}
				// 반품 완료
				case 2: {
					// 상세 주문 수량
					paramMap.put("orderQuantity", dto.getOrderQuantity());
					
					int returnableQuantity = getReturnableQuantity(paramMap);
					
					// 반품 가능 수량이 없는 경우
					if(returnableQuantity == 0) {
						paramMap.put("detailState", 12);
						paramMap.put("stateMemo", "반품완료");
					} else {
						paramMap.put("detailState", 18);
						paramMap.put("stateMemo", "부분반품완료");
					}
					break;
				}
				// 반품 기각
				case 3: {
					paramMap.put("detailState", 13);
					paramMap.put("stateMemo", "반품불가");
					break;
				}
			}
			
			myPageService.updateOrderDetailState(paramMap);
			
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

	@Override
	public List<Integer> getMyProcessedReturnQuantity(Map<String, Object> map) {		
		List<Integer> list = null;
		
		try {
			list = mapper.getMyProcessedReturnQuantity(map);
	
			
		} catch (Exception e) {
			log.info("getMyProcessedReturnQuantity : ", e);
			
			throw e;
		}
		
		return list;
	}

	@Override
	public int getReturnableQuantity(Map<String, Object> map) {
		// 반품 가능 수량
		int returnableQuantity = 0;
		
		try {
			// 반품 불가 수량 목록
			List<Integer> quantityList = getMyProcessedReturnQuantity(map);

			// 주문 수량
			returnableQuantity = (int)map.get("orderQuantity");

			for(int processedQuantity : quantityList) {
				// 반품 가능 수량 = 주문 수량 - 반품 불가 수량
				returnableQuantity = returnableQuantity - processedQuantity;
				
				if(returnableQuantity == 0) {
					return 0;
				}
			}
			
		} catch (Exception e) {
			log.info("getReturnableQuantity : ", e);
			
			throw e;
		}
		
		return returnableQuantity;
	}

}
