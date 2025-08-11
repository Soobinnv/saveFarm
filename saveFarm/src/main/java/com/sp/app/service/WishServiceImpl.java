package com.sp.app.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.WishMapper;
import com.sp.app.model.Wish;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class WishServiceImpl implements WishService{

	private final WishMapper mapper;
	
	@Override
	public void insertWish(Map<String, Object> map) throws SQLException {
		try {
			mapper.insertWish(map);
			
		} catch (Exception e) {
			log.info("insertWish : ", e);
			
			throw e;
		}
	}

	@Override
	public List<Wish> getWishList(long memberId) {
		List<Wish> list = null;
		
		try {
			list = mapper.getWishList(memberId);
			
			for(Wish dto : list) {
				int discountedPrice = 0;
				if(dto.getDiscountRate() > 0) {
					discountedPrice = (int)(dto.getUnitPrice() * (1 - (dto.getDiscountRate() / 100.0)));
					dto.setDiscountedPrice(discountedPrice);				
				}
			}
			
		} catch (Exception e) {
			log.info("getWishList : ", e);
		}
		
		return null;
	}

	@Override
	public Wish findByWishId(Map<String, Object> map) {
		Wish dto = null;
		
		try {
			dto = mapper.findByWishId(map);
		} catch (Exception e) {
			log.info("findByWishId : ", e);
		}
		
		return dto;
	}

	@Override
	public void deleteWish(Map<String, Object> map) throws Exception {
		try {
			mapper.deleteWish(map);
		} catch (Exception e) {
			log.info("deleteWish : ", e);
			
			throw e;
		}
	}

}
