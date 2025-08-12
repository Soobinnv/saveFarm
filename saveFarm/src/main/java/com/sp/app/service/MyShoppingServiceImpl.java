package com.sp.app.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.MyShoppingMapper;
import com.sp.app.model.Destination;
import com.sp.app.model.Order;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class MyShoppingServiceImpl implements MyShoppingService {
	private final MyShoppingMapper mapper;
	
	@Override
	public void insertCart(Order dto) throws Exception {
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("memberId", dto.getMemberId());
			
			for(int i = 0 ; i < dto.getProductNums().size(); i++) {
				dto.setProductNum(dto.getProductNums().get(i));
				dto.setQty(dto.getBuyQtys().get(i));
				
				map.put("productNum", dto.getProductNums().get(i));
				
				if(mapper.findByCartId(map) == null) {
					mapper.insertCart(dto);
				} else {
					mapper.updateCart(dto);
				}
			}
		} catch (Exception e) {
			log.info("insertCart : ", e);
			
			throw e;
		}
	}

	@Override
	public List<Order> listCart(Long memberId) {
		List<Order> list = null;
		
		try {
			list = mapper.listCart(memberId);
			
			for(Order dto : list) {
				int discountPrice = 0;
				if(dto.getDiscountRate() > 0) {
					discountPrice = (int)(dto.getUnitPrice() * (dto.getDiscountRate()/100.0));
					dto.setDiscountPrice(discountPrice);
				}
				
				dto.setSalePrice(dto.getUnitPrice() - discountPrice);
				dto.setProductMoney(dto.getSalePrice() * dto.getQty());
			}
		} catch (Exception e) {
			log.info("listCart : ", e);
		}
		
		return list;
	}

	@Override
	public void deleteCart(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void insertDestination(Destination dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int destinationCount(Long memberId) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Destination> listDestination(Long memberId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateDestination(Destination dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateDefaultDestination(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteDestination(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Destination defaultDelivery(Long memberId) {
		// TODO Auto-generated method stub
		return null;
	}

}
