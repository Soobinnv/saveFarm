package com.sp.app.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;

import org.springframework.stereotype.Service;
import com.sp.app.controller.OrderController;
import com.sp.app.mapper.MyPageMapper;
import com.sp.app.mapper.OrderMapper;
import com.sp.app.mapper.PackageMapper;
import com.sp.app.mapper.ProductMapper;
import com.sp.app.model.Order;
import com.sp.app.model.PackageOrder;
import com.sp.app.model.Payment;
import com.sp.app.model.Product;
import com.sp.app.state.OrderState;

import jakarta.mail.FetchProfile.Item;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class MyPageServiceImpl implements MyPageService {
	private final MyPageMapper mapper;
	private final OrderMapper orderMapper;
	private final PackageMapper PackageMapper;
	private final ProductMapper productMapper;

	
	@Override
	public int countPayment(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = mapper.countPayment(map);
		} catch (Exception e) {
			log.info("countPayment : ", e);
		}
		
		return result;
	}

	@Override
	public List<Payment> listPayment(Map<String, Object> map) {
		List<Payment> list = null;
		
		try {
			// OrderState.ORDERSTATEINFO : 주문상태 정보
			// OrderState.DETAILSTATEINFO : 주문상세상태 정보
			
			String productState;
			
			list = mapper.listPayment(map);

			Date endDate = new Date();
			long gap;
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			
			for(Payment dto : list) {
				dto.setOrderDate(dto.getOrderDate().replaceAll("-", ".").substring(5,10));
				dto.setOrderStateInfo(OrderState.ORDERSTATEINFO[dto.getOrderState()]);
				dto.setDetailStateInfo(OrderState.DETAILSTATEINFO[dto.getDetailState()]);
				
				if(dto.getOrderState() == 7 || dto.getOrderState() == 9) {
					productState = "결제완료";
				} else {
					productState = OrderState.ORDERSTATEINFO[dto.getOrderState()];
				}
				if(dto.getDetailState() > 0) {
					productState = OrderState.DETAILSTATEINFO[dto.getDetailState()];
				}
				dto.setStateProduct(productState);
				
				// 배송 완료후 지난 일자
				if(dto.getOrderState() == 5 && dto.getStateDate() != null) {
					Date beginDate = formatter.parse(dto.getStateDate());
					gap = (endDate.getTime() - beginDate.getTime()) / (24 * 60 * 60 * 1000);
					dto.setAfterDelivery(gap);
				}
			}

		} catch (Exception e) {
			log.info("listPayment : ", e);
		}
		
		return list;
	}
	
	// 퍼처스(구매) 리스트
	public List<Payment> listPurchase(Map<String, Object> map) {
		List<Payment> list = null;
		
		try {
			list = mapper.listPurchase(map);
		} catch (Exception e) {
			log.info("listPurchase : ", e);
		}
		
		return list;
	}

	@Override
	public Payment findByOrderDetail(Map<String, Object> map) {
		Payment dto = null;
		
		try {
			dto = Objects.requireNonNull(mapper.findByOrderDetail(map));
			
			if((dto.getOrderState() == 1 || dto.getOrderState() == 7 || dto.getOrderState() == 9)
					&& dto.getDetailState() == 0) {
				dto.setDetailStateInfo("상품 준비중");
			} else {
				dto.setDetailStateInfo(OrderState.DETAILSTATEMANAGER[dto.getDetailState()]);
			}
			
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("findByOrderDetail : ", e);
		}
		
		return dto;
	}
	
	@Override
	public Order findByOrderDelivery(Map<String, Object> map) {
		Order dto = null;
		
		try {
			dto = mapper.findByOrderDelivery(map);
		} catch (Exception e) {
			log.info("findByOrderDelivery : ", e);
		}
		
		return dto;
	}
	
	@Override
	public void updateOrderDetailState(Map<String, Object> map) throws Exception {
		try {
			// orderDetail 테이블 상태 변경
			mapper.updateOrderState(map);
			
			// detailStateInfo 테이블에 상태 변경 내용 및 날짜 저장
			mapper.insertDetailStateInfo(map);
			
			int detailState = Integer.parseInt(Optional.ofNullable((String)map.get("detailState")).orElse("0"));
			if(detailState == 1) {
				// 구매 확정인 경우 적립금 추가
				long orderDetailNum = Long.parseLong((String)map.get("orderDetailNum"));
				Long member_id = (Long)map.get("member_id");
				
				Order order = orderMapper.findByOrderDetail(orderDetailNum);
				
			}

		} catch (Exception e) {
			log.info("updateOrderDetailState : ", e);
			
			throw e;
		}
	}
	
	@Override
	public void updateOrderHistory(long orderDetailNum) throws Exception {
		try {
			mapper.updateOrderHistory(orderDetailNum);
		} catch (Exception e) {
			log.info("updateOrderHistory : ", e);
			
			throw e;
		}
	}

	@Override
	public List<PackageOrder> findMySubinfo(long memberId) throws Exception {
		List<PackageOrder> list = null;
		
		try {
			// 최근 
			list = PackageMapper.mysubinfo(memberId);
			
			for (int i = 0; i < list.size(); i++) {
			    List<Long> productNums = new ArrayList<>();
			    List<Integer> itemPrices = new ArrayList<>();
			    List<Integer> counts = new ArrayList<>();

			    PackageOrder dto = list.get(i);
			    System.out.println(dto.getSubNum());

			    // 패키지 기본정보
			    PackageOrder packageInfo = PackageMapper.subPackageinfo(dto.getSubNum());
			    List<PackageOrder> items = PackageMapper.subItemList(dto.getSubNum());

			    dto.setHomePackageNum(packageInfo.getHomePackageNum());
			    dto.setSaladPackageNum(packageInfo.getSaladPackageNum());
			    dto.setPackagePrice(packageInfo.getPackagePrice());
			    

			    if (items == null || items.isEmpty()) {
			        dto.setProductNums(Collections.emptyList());
			        dto.setItemPrices(Collections.emptyList());
			        dto.setCounts(Collections.emptyList());
			    } else {
			        dto.setProductNums(items.stream().map(PackageOrder::getProductNum).toList());
			        dto.setItemPrices(items.stream().map(PackageOrder::getItemPrice).toList());
			        dto.setCounts(items.stream().map(PackageOrder::getCount).toList());
			    }
			    
			    
			    if (dto.getProductNames() == null) {
			        dto.setProductNames(new ArrayList<>());
			    }
			    if (dto.getMainImageFileNames() == null) {
			        dto.setMainImageFileNames(new ArrayList<>());
			    }
			    
			    
			    for (int j = 0; j < items.size(); j++) {   
			        Product productInfo = productMapper.getProductInfo(items.get(j).getProductNum());

			        if (productInfo != null) {
			            dto.getProductNames().add(productInfo.getProductName());
			            dto.getMainImageFileNames().add(productInfo.getMainImageFilename());

			            // syso로 로그 확인
			            System.out.println("추가된 상품명: " + productInfo.getProductName());
			            System.out.println("추가된 이미지: " + productInfo.getMainImageFilename());
			            System.out.println("현재 productNames 리스트: " + dto.getProductNames());
			            System.out.println("현재 mainImageFileNames 리스트: " + dto.getMainImageFileNames());
			        } else {
			            System.out.println("productInfo == null -> productNum=" + items.get(j).getProductNum());
			        }
			    }
			    
			    dto.setReviewExists(mapper.findBysubReview(dto.getSubNum()));
			    System.out.println("ReviewExists: "+dto.getReviewExists());
			    
			}
			
			
		} catch (Exception e) {
			log.info("findMySubinfo: ",e);
			
			throw e;
		}
		
		
		return list;
	}

	@Override
	public Payment findByOrderDetailDelivery(Map<String, Object> map) {
		Payment dto = null;
		
		try {
			dto = Objects.requireNonNull(mapper.findByOrderDetailDelivery(map));
			
			if(dto.getOrderState() > 1 && dto.getOrderState() <= 4 ){
				dto.setInvoiceNumber(dto.getInvoiceNumber());
				dto.setDeliveryName(dto.getDeliveryName());
			} else {
				dto.setInvoiceNumber("발송준비중");
				dto.setDeliveryName("");
			}
			
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("findByOrderDetail : ", e);
		}
		
		return dto;
	}
}
