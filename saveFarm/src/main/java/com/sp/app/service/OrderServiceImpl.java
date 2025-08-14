package com.sp.app.service;

import java.util.Calendar;
import java.util.List;
import java.util.Map;
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
			String y = String.format("%04d", cal.get(Calendar.YEAR));
			String m = String.format("%02d", cal.get(Calendar.MONTH) + 1);
			String d = String.format("%03d", cal.get(Calendar.DATE) * 7);
			
			String preNumber = y + m + d;
			String savedPreNumber = "0";
			long savedLastNumber = 0;
			String maxOrderNumber = mapper.findByMaxOrderNumber();
			if(maxOrderNumber != null && maxOrderNumber.length() > 9) {
				savedPreNumber = maxOrderNumber.substring(0, 9);
				savedLastNumber = Long.parseLong(maxOrderNumber.substring(9));
			}
			
			long lastNumber = 1;
			if(! preNumber.equals(savedPreNumber)) {
				count.set(0);
				lastNumber = count.incrementAndGet();
			} else {
				lastNumber = count.incrementAndGet();
				
				if( savedLastNumber >= lastNumber ) {
					count.set(savedLastNumber);
					lastNumber = count.incrementAndGet();
				}
			}
			
			result = preNumber + String.format("%09d", lastNumber);
			
		} catch (Exception e) {
			log.info("productOrderNumber : ", e);
		}
		
		return result;
	}

	@Override
	public void insertOrder(Order dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Order> listOrderProduct(List<Map<String, Long>> list) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Order> listOptionDetail(List<Long> detailNums) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Order findByOrderDetail(long orderDetailNum) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Order findByProduct(long productNum) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Order findByOptionDetail(long detailNum) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Order findByOrderState(long orderNum) {
		// TODO Auto-generated method stub
		return null;
	}

}
