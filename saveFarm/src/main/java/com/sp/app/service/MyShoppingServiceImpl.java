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
		try {
			mapper.deleteCart(map);
		} catch (Exception e) {
			log.info("deleteCart : ", e);
			
			throw e;
		}
	}

	@Override
	public void insertDestination(Destination dto) throws Exception {
		try {
			
			if(dto.getDefaultDest() == 1) {
				Map<String, Object> map = new HashMap<>();
				map.put("memberId", dto.getMemberId());
				map.put("defaultDest", 0);
				mapper.updateDefaultDestination(map);
			}
			
			mapper.insertDestination(dto);
			
			// 최근 10개만 남기고 삭제
			mapper.deleteOldestDestination(dto.getMemberId());			
			
		} catch (Exception e) {
			log.info("insertDestination : ", e);
			
			throw e;
		}
	}

	@Override
	public int destinationCount(Long memberId) {
		int result = 0;
		
		try {
			result = mapper.destinationCount(memberId);
		} catch (Exception e) {
			log.info("destinationCount : ", e);
		}
		
		return result;
	}

	@Override
	public List<Destination> listDestination(Long memberId) {
		List<Destination> list = null;
		
		try {
			list = mapper.listDestination(memberId);
			
			for(Destination dto : list) {
				String [] tel = dto.getTel().split("-");
				if(tel.length == 3) {
					dto.setTel1(tel[0]);
					dto.setTel2(tel[1]);
					dto.setTel3(tel[2]);
				}
			}
			
		} catch (Exception e) {
			log.info("listDestination : ", e);
		}
		
		return list;
	}

	// in MyShoppingServiceImpl.java

	@Override
	public void updateDestination(Destination dto) throws Exception {
	    try {
	    	
	        if(dto.getDefaultDest() == 1) {
	            Map<String, Object> map = new HashMap<>();
	            map.put("memberId", dto.getMemberId());
	            map.put("defaultDest", 0);
	            mapper.updateDefaultDestination(map);
	        }
	        
	        mapper.updateDestination(dto);
	    } catch (Exception e) {
	        log.info("updateDestination : ", e); // log.info 보다 log.error가 더 적합합니다.
	        throw e;
	    }
	}

	@Override
	public void updateDefaultDestination(Map<String, Object> map) throws Exception {
		try {
			mapper.updateDefaultDestination(map);
		} catch (Exception e) {
			log.info("updateDefaultDestination : ", e);
			
			throw e;
		}
	}

	@Override
	public void deleteDestination(Map<String, Object> map) throws Exception {
		try {
			mapper.deleteDestination(map);
		} catch (Exception e) {
			log.info("deleteDestination : ", e);
			
			throw e;
		}	
	}

	@Override
	public Destination defaultDelivery(Long memberId) {
		Destination dto = null;
		
		try {
			dto = mapper.defaultDelivery(memberId);
		} catch (Exception e) {
			log.info("defaultDelivery : ", e);
		}
		
		return dto;
	}
	
	@Override
	   public int getCartSize(Long memberId) {
	      int size = 0;
	      
	      try {
	         size = mapper.getCartSize(memberId);
	      } catch (Exception e) {
	         log.info("getCartSize : ", e);
	         
	         throw e;
	      }
	      return size;
	   }



}
