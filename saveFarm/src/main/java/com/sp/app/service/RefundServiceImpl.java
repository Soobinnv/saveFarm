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
			paramMap.put("memberId", dto.getMemberId());
			paramMap.put("orderQuantity", dto.getOrderQuantity());

			int refundableQuantity = getRefundableQuantity(paramMap);
			
			// 환불가능 수량 = 환불 요청 수량
			if(refundableQuantity == dto.getQuantity()) {
				// 주문 상세 - 주문 취소 요청 상태로 변경
				paramMap.put("detailState", 15);
				paramMap.put("stateMemo", "환불요청");
			} else {
				paramMap.put("detailState", 17);
				paramMap.put("stateMemo", "부분환불요청");				
			}
			
			myPageService.updateOrderDetailState(paramMap);
		} catch (Exception e) {
			log.info("insertRefund : ", e);
			
			throw e;
		}
	}

	@Transactional
	@Override
	public void updateRefund(Refund dto, String uploadPath) throws Exception {
		try {
			mapper.updateRefund(dto);
			
			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("orderDetailNum", dto.getOrderDetailNum());
			paramMap.put("memberId", dto.getMemberId());
			
			int status = dto.getStatus();
			
			switch (status) {
				// 환불 접수
				case 1: {
					paramMap.put("detailState", 21);
					paramMap.put("stateMemo", "환불접수");
					break;
				}
				// 환불 완료
				case 2: {
					// 상세 주문 수량
					paramMap.put("orderQuantity", dto.getOrderQuantity());
					
					int refundableQuantity = getRefundableQuantity(paramMap);
					
					// 반품 가능 수량이 없는 경우
					if(refundableQuantity == 0) {
						paramMap.put("detailState", 20);
						paramMap.put("stateMemo", "환불완료");
					} else {
						paramMap.put("detailState", 19);
						paramMap.put("stateMemo", "부분환불완료");
					}
					break;
				}
				// 환불 기각
				case 3: {
					paramMap.put("detailState", 22);
					paramMap.put("stateMemo", "환불불가");
					break;
				}
			}
			
			myPageService.updateOrderDetailState(paramMap);
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

	@Override
	public Refund getRefundInfo(Map<String, Object> map) {
		Refund dto = null;
		
		try {
			dto = mapper.getRefundInfo(map);
		} catch (Exception e) {
			log.info("getRefundInfo : ", e);
			
			throw e;
		}
		
		return dto;
	}

	@Override
	public List<Integer> getMyProcessedRefundAmount(Map<String, Object> map) {
		List<Integer> list = null;
		
		try {
			list = mapper.getMyProcessedRefundAmount(map);
	
			
		} catch (Exception e) {
			log.info("getMyProcessedRefundAmount : ", e);
			
			throw e;
		}
		
		return list;
	}

	@Override
	public int getRefundableQuantity(Map<String, Object> map) {
		// 환불 가능 수량
		int refundableQuantity = 0;
		
		try {
			// 환불 불가 수량 목록
			List<Integer> quantityList = getMyProcessedRefundAmount(map);

			// 주문 수량
			refundableQuantity = (int)map.get("orderQuantity");

			for(int processedQuantity : quantityList) {
				// 환불 가능 수량 = 주문 수량 - 환불 불가 수량
				refundableQuantity = refundableQuantity - processedQuantity;
				
				if(refundableQuantity == 0) {
					return 0;
				}
			}
			
		} catch (Exception e) {
			log.info("getReturnableQuantity : ", e);
			
			throw e;
		}
		
		return refundableQuantity;
	}

}
