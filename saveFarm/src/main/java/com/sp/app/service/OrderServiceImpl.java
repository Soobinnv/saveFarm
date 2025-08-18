package com.sp.app.service;

import java.util.Calendar;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.concurrent.atomic.AtomicLong;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.OrderMapper;
import com.sp.app.model.Order;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class OrderServiceImpl implements OrderService{
	private final OrderMapper mapper;
	
	private static AtomicLong count = new AtomicLong(0);
	
	@Override
	public String productOrderNumber() {
		// 상품 주문 번호 생성
		String result = "";
		
		try {
			Calendar cal = Calendar.getInstance();
			String y =String.format("%04d", cal.get(Calendar.YEAR));
			String m = String.format("%02d", (cal.get(Calendar.MONTH) + 1));
			String d = String.format("%03d", cal.get(Calendar.DATE) * 7);
			
			String preNumber = y + m + d;
			String savedPreNumber = "0";
			long savedLastNumber = 0;
			String maxOrderNumber = mapper.findByMaxOrderNumber();
			if(maxOrderNumber != null && maxOrderNumber.length() > 9) {
				savedPreNumber = maxOrderNumber.substring(0, 9);
				savedLastNumber = Long.parseLong(maxOrderNumber.substring(9));
			}
			
			long lastNumber = 2;
			if(! preNumber.equals(savedPreNumber)) {
				count.set(0);
				lastNumber = count.incrementAndGet();
			} else {
				lastNumber = count.incrementAndGet();
				
				if( savedLastNumber >= lastNumber )  {
					count.set(savedLastNumber);
					lastNumber = count.incrementAndGet();
				}
			}
			
			result = preNumber + String.format("%09d", lastNumber);
			
			System.out.println(result);
		} catch (Exception e) {
			log.info("productOrderNumber : ", e);
		}
		
		return result;
	}

	@Override
	public void insertOrder(Order dto) throws Exception {
		try {
			// 주문 정보 저장
			mapper.insertOrder(dto);
			
			// 결제 내역 저장
			mapper.insertPayDetail(dto);
			
			// 상세 주문 정보 및 주문 상태 저장
			for(int i=0; i <dto.getProductNums().size(); i++) {
				dto.setProductNum(dto.getProductNums().get(i));
				dto.setQty(dto.getBuyQtys().get(i));
				dto.setProductMoney(dto.getProductMoneys().get(i));
				dto.setUnitPrice(dto.getUnitPrices().get(i));
				dto.setSalePrice(dto.getSalePrices().get(i));
				
				// 상세 주문 정보 저장
				mapper.insertOrderDetail(dto);
				
				// 판매 개수만큼 재고 감소
				dto.setProductNum(dto.getProductNums().get(i));
				mapper.updateProductStockDec(dto);
			}
			
			// 배송지 저장
			mapper.insertOrderDelivery(dto);
		} catch (Exception e) {
			log.info("insertOrder : ", e);
		
			throw e;
		}
		
	}

	@Override
	public List<Order> listOrderProduct(List<Map<String, Long>> list) {
		List<Order> listProduct = null;
		
		try {
			listProduct = mapper.listOrderProduct(list);
			for(Order dto : listProduct) {
				int discountPrice = 0;
				if(dto.getDiscountRate() > 0) {
					discountPrice = (int)(dto.getUnitPrice() * (dto.getDiscountRate() / 100.0));
					dto.setDiscountPrice(discountPrice);
				}
				
				dto.setSalePrice(dto.getUnitPrice() - discountPrice);
			}
		} catch (Exception e) {
			log.info("listOrderProduct : ", e);
		}
		
		return listProduct;
	}

	@Override
	public List<Order> listOptionDetail(List<Long> detailNums) {
		List<Order> listOptionDetail = null;
		
		try {
			listOptionDetail = mapper.listOptionDetail(detailNums);
		} catch (Exception e) {
			log.info("listOptionDetail : ", e);
		}
		
		return listOptionDetail;
	}

	@Override
	public Order findByOrderDetail(long orderDetailNum) {
		Order dto = null;
		
		try {
			dto = mapper.findByOrderDetail(orderDetailNum);
		} catch (Exception e) {
			log.info("findByOrderDetail : ", e);
		}
		
		return dto;
	}

	@Override
	public Order findByProduct(long productNum) {
		Order dto = null;
		
		try {
			dto = Objects.requireNonNull(mapper.findByProduct(productNum)); 
		
			int discountPrice = 0;
			if(dto.getDiscountRate() > 0) {
				discountPrice = (int)(dto.getUnitPrice() * (dto.getDiscountRate() / 100.0));
				dto.setDiscountPrice(discountPrice);
			}
			
			dto.setSalePrice(dto.getUnitPrice() - discountPrice);
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("findByProduct : ", e);
		}
		
		return dto;
	}

	@Override
	public Order findByOptionDetail(long detailNum) {
		Order dto = null;
		
		try {
			dto = mapper.findByOptionDetail(detailNum); 
		} catch (Exception e) {
			log.info("findByOptionDetail : ", e);
		}
		
		return dto;
	}

	@Override
	public void updateOrderState(Order dto) {
		try {
			dto.setOrderNum(dto.getOrderNum());
			mapper.updateOrderState(dto);
		} catch (Exception e) {
			log.info("updateOrderState : ", e);
		}
	}

}
