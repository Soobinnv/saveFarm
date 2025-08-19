package com.sp.app.service;

import java.util.ArrayList;
import java.util.HashMap;
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
	public Map<String, List<Product>> getAllProductList(Map<String, Object> map) {
		Map<String, List<Product>> resultMap = new HashMap<>();
		List<Product> productList = new ArrayList<>();
		List<Product> rescuedProductList = new ArrayList<>();
		
		try {
			// 전체 상품 리스트
			List<Product> allProductList = mapper.getAllProductList(map);
			
			int discountedPrice = 0;
			for(Product dto : allProductList) {
				// 할인가격 계산
				if(dto.getDiscountRate() > 0) {
					discountedPrice = (int)(dto.getUnitPrice() * (1 - (dto.getDiscountRate() / 100.0)));
					dto.setDiscountedPrice(discountedPrice);				
				}
				
				// 리스트 분리
				if(dto.getProductClassification() == 100) {
					// 일반 상품
					productList.add(dto);
				} else if(dto.getProductClassification() == 200) {
					// 구출 상품
					rescuedProductList.add(dto);
				}
				
				resultMap.put("productList", productList);
				resultMap.put("rescuedProductList", rescuedProductList);					
			}
			
		} catch (Exception e) {
			log.info("getAllProductList : ", e);
		}
		
		return resultMap;
	}
	
	@Override
	public List<Product> getProductList(Map<String, Object> map) {
		List<Product> list = null;
		
		try {
			list = mapper.getProductList(map);
			
			int discountedPrice = 0;
			for(Product dto : list) {
				if(dto.getDiscountRate() > 0) {
					discountedPrice = (int)(dto.getUnitPrice() * (1 - (dto.getDiscountRate() / 100.0)));
					dto.setDiscountedPrice(discountedPrice);				
				}				
			}
			
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

	@Override
	public List<Product> getRescuedProductList(Map<String, Object> map) {
		List<Product> list = null;
		
		try {
			list = mapper.getRescuedProductList(map);
			
			int discountedPrice = 0;
			for(Product dto : list) {
				if(dto.getDiscountRate() > 0) {
					discountedPrice = (int)(dto.getUnitPrice() * (1 - (dto.getDiscountRate() / 100.0)));
					dto.setDiscountedPrice(discountedPrice);				
				}				
			}
			
		} catch (Exception e) {
			log.info("getRescuedProductList : ", e);
		}
		
		return list;
	}

	@Override
	public Product getRescuedProductInfo(long productNum) {
		Product dto = null;
		
		try {
			dto = mapper.getRescuedProductInfo(productNum);
			
			int discountedPrice = 0;
			if(dto.getDiscountRate() > 0) {
				discountedPrice = (int)(dto.getUnitPrice() * (1 - (dto.getDiscountRate() / 100.0)));
				dto.setDiscountedPrice(discountedPrice);				
			}
			
		} catch (Exception e) {
			log.info("getRescuedProductInfo : ", e);
		}
		
		return dto;
	}

	@Override
	public List<Product> getProductImageList(long productNum) {
		List<Product> list = null;
		
		try {
			list = mapper.getProductImageList(productNum);
		} catch (Exception e) {
			log.info("getProductImageList : ", e);
		}
		
		return list;
	}

	@Override
	public void insertProduct(Product dto, String uploadPath) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void insertProductDetail(Product dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void insertRescuedProduct(Product dto, String uploadPath) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateProduct(Product dto, String uploadPath) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateProductDetail(Product dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateRescuedProduct(Product dto, String uploadPath) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteProduct(long productNum, String uploadPath) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean deleteProductImageFile(String uploadPath, String filename) {
		// TODO Auto-generated method stub
		return false;
	}


}
