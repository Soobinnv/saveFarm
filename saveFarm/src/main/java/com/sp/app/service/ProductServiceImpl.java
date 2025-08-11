package com.sp.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.ProductMapper;
import com.sp.app.model.Product;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ProductServiceImpl implements ProductService {
	private final ProductMapper mapper;
	
	@Override
	public List<Product> getProductList(Map<String, Object> map) {
		List<Product> list = null;
		
		try {
			list = mapper.getProductList(map);
		} catch (Exception e) {
			log.info("getProductList : ", e);
		}
		
		return list;
	}

	@Override
	public Product getProductInfo(long productNum) {
		Product dto = null;
		
		try {
			dto = mapper.getProductInfo(productNum);
			
			int discountedPrice = 0;
			if(dto.getDiscountRate() > 0) {
				discountedPrice = (int)(dto.getUnitPrice() * (1 - (dto.getDiscountRate() / 100.0)));
				dto.setDiscountedPrice(discountedPrice);				
			}
			
		} catch (Exception e) {
			log.info("getProductInfo : ", e);
		}
		
		return dto;
	}
}
