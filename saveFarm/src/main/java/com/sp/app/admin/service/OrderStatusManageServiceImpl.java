package com.sp.app.admin.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Service;

import com.sp.app.admin.mapper.OrderManageMapper;
import com.sp.app.admin.model.OrderDetailManage;
import com.sp.app.admin.model.OrderManage;
import com.sp.app.mapper.OrderMapper;
import com.sp.app.state.OrderState;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class OrderStatusManageServiceImpl implements OrderStatusManageService {
	private final OrderManageMapper mapper;
	private final OrderMapper orderMapper;
	
	@Override
	public int orderCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = mapper.orderCount(map);
		} catch (Exception e) {
			log.info("orderCount : ", e);
		}
		
		return result;
	}

	@Override
	public List<OrderManage> listOrder(Map<String, Object> map) {
		List<OrderManage> list = null;

		// OrderState.ORDERSTATEINFO : 주문상태 정보
		// OrderState.DETAILSTATEMANAGER : 주문상세상태 정보(관리자)
		
		try {
			list = mapper.listOrder(map);
			for(OrderManage dto : list) {
				dto.setOrderStateInfo(OrderState.ORDERSTATEINFO[dto.getOrderState()]);
			}
		} catch (Exception e) {
			log.info("listOrder : ", e);
		}
		
		return list;
	}
	
	@Override
	public OrderManage findByOrderId(String orderNum) {
		OrderManage dto = null;
		
		// OrderState.ORDERSTATEINFO : 주문상태 정보
		
		try {
			dto = Objects.requireNonNull(mapper.findByOrderId(orderNum));
			
			dto.setOrderStateInfo(OrderState.ORDERSTATEINFO[dto.getOrderState()]);
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("findByOrderId : ", e);
		}
		
		return dto;
	}

	@Override
	public List<OrderDetailManage> listOrderDetails(String orderNum) {
		List<OrderDetailManage> list = null;

		// OrderState.DETAILSTATEMANAGER : 주문상세상태 정보(관리자)
		
		try {
			list = mapper.listOrderDetails(orderNum);
			
			for(OrderDetailManage dto : list) {
				dto.setDetailStateInfo(OrderState.DETAILSTATEMANAGER[dto.getDetailState()]);
			}
		} catch (Exception e) {
			log.info("listOrderDetails : ", e);
		}
		
		return list;
	}

	@Override
	public int detailCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = mapper.detailCount(map);
		} catch (Exception e) {
			log.info("detailCount : ", e);
		}
		
		return result;
	}

	@Override
	public List<OrderDetailManage> listDetails(Map<String, Object> map) {
		List<OrderDetailManage> list = null;
		
		try {
			list = mapper.listDetails(map);
			
			for(OrderDetailManage dto : list) {
				dto.setDetailStateInfo(OrderState.DETAILSTATEMANAGER[dto.getDetailState()]);
			}			
		} catch (Exception e) {
			log.info("listDetails : ", e);
		}
		return list;
	}

	@Override
	public OrderDetailManage findByDetailId(Long orderDetailNum) {
		OrderDetailManage dto = null;
		
		try {
			dto = Objects.requireNonNull(mapper.findByDetailId(orderDetailNum));
			
			dto.setDetailStateInfo(OrderState.DETAILSTATEMANAGER[dto.getDetailState()]);
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("findByDetailId : ", e);
		}
		
		return dto;
	}
	
	@Override
	public void updateOrder(String mode, Map<String, Object> map) throws Exception {
		try {
			if(mode.equals("state")) {
				mapper.updateOrderState(map);
			} else if(mode.equals("invoiceNumber")) { // 송장번호 등록
				String deliveryName = (String)map.get("deliveryName");
				long deliveryCompanyNum = mapper.selectDeliveryNum(deliveryName);
				map.put("deliveryCompanyNum", deliveryCompanyNum);
				mapper.insertOrderInvoiceNumber(map);
				mapper.updateOrderState(map);
			} else if(mode.equals("delivery")) { // 배송 변경
				mapper.updateDeliveryState(map);
				mapper.updateOrderState(map);
			} else if(mode.equals("cancelAmount")) { // 주문취소 금액 수정
				mapper.updateCancelAmount(map);
			}
		} catch (Exception e) {
			log.info("updateOrder : ", e);
			
			throw e;
		}
	}

	@Override
	public void updateOrderDetailState(Map<String, Object> map) throws Exception {
		try {
			String orderNum = (String)map.get("orderNum");
			int detailState = Integer.parseInt((String)map.get("detailState"));
			int productMoney = Integer.parseInt((String)map.get("productMoney"));
			int payment = Integer.parseInt((String)map.get("payment"));
			
			// 주문에 대한 전체 취소 금액 가져오기
			int cancelAmount = 0;
			if(detailState == 3 || detailState == 5 || detailState == 12) {
				// totalCancelAmount = dao.selectOne("adminOrder.readTotalCancelAmount", orderNum);
				cancelAmount = Integer.parseInt((String)map.get("cancelAmount"));
			}
			
			// orderDetail 테이블 상태 변경
			mapper.updateOrderDetailState(map);
			
			// detailStateInfo 테이블에 상태 변경 내용 및 날짜 저장
			mapper.insertDetailStateInfo(map);

			// productOrder 테이블 취소금액 변경
			// 환불-개별판매취소(관리자),주문취소완료(관리자),반품완료(관리자)
			if(detailState == 3 || detailState == 5 || detailState == 12) {
				cancelAmount += productMoney;
				int amount = cancelAmount;
				if(cancelAmount > payment) {
					amount = payment;
				}
				
				map.put("cancelAmount", amount);

				mapper.updateCancelAmount(map);
				
				// 주문정보의 상태 변경
				int totalOrderCount = mapper.totalOrderCount(orderNum);
				if(totalOrderCount == 0) { // 모두 취소
					if(detailState == 3) {
						map.put("orderState", 6); // 전체판매취소(관리자)
					} else if(detailState == 5) {
						map.put("orderState", 8); // 전체주문취소
					} else {
						map.put("orderState", 10); // 전체반품취소
					}
				} else { // 부분 취소
					if(detailState == 3) {
						map.put("orderState", 7); // 부분판매취소(관리자)
					} else if(detailState == 5) {
						map.put("orderState", 9); // 부분주문취소
					} else {
						map.put("orderState", 11); // 부분반품취소
					}
				}
				mapper.updateOrderState(map);
				
				// 판매취소 개수 만큼 재고 증가 -----
				mapper.updateProductStockInc(map);
				
				// 카드 취소내역 저장
				
			}
			
		} catch (Exception e) {
			log.info("updateOrderDetailState : ", e);
			
			throw e;
		}
	}
	
	@Override
	public List<Map<String, Object>> listDeliveryCompany() {
		List<Map<String, Object>> list = null;
		
		try {
			list = mapper.listDeliveryCompany();
		} catch (Exception e) {
			log.info("listDeliveryCompany : ", e);
		}
		
		return list;
	}
	
	@Override
	public List<Map<String, Object>> listDetailStateInfo(long orderDetailNum) {
		List<Map<String, Object>> list = null;
		
		// OrderState.DETAILSTATEMANAGER : 주문상세상태 정보(관리자)
		try {
			list = mapper.listDetailStateInfo(orderDetailNum);
			
			String detalStateInfo;
			for(Map<String, Object> map : list) {
				int detailState = ((BigDecimal) map.get("DETAILSTATE")).intValue(); 
				detalStateInfo = OrderState.DETAILSTATEMANAGER[detailState];
				map.put("DETALSTATEINFO", detalStateInfo);
			}
		} catch (Exception e) {
			log.info("listDetailStateInfo : ", e);
		}
		
		return list;
	}
	
	@Override
	public OrderManage findByDeliveryId(String orderNum) {
		OrderManage dto = null;
		
		try {
			dto = mapper.findByDeliveryId(orderNum);
		} catch (Exception e) {
			log.info("findByDeliveryId : ", e);
		}
		
		return dto;
	}
	
	@Override
	public Map<String, Object> findByPayDetail(String orderNum) {
		Map<String, Object> map = null;
		
		try {
			map = mapper.findByPayDetail(orderNum);
		} catch (Exception e) {
			log.info("findByPayDetail : ", e);
		}
		
		return map;
	}

	@Override
	public OrderManage findInvoiceNumber(String orderNum) {
		OrderManage dto = null;
		
		try {
			dto = mapper.findInvoiceNumber(orderNum);
		} catch (Exception e) {
			log.info("findInvoiceNumber : ", e);
		}
		
		return dto;
	}
}
