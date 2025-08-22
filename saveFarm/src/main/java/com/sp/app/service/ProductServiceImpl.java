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
	private final ProductReviewService reviewService;
	private final WishService wishService;
	
	@Override
	public Product getProductWithDetails(long productNum, int classifyCode, long memberId) throws Exception {
		Product productInfo = null;
		
		try {
			if(classifyCode == 100) {
				productInfo = getProductInfo(productNum);				
			} else if(classifyCode == 200) {
				productInfo = getRescuedProductInfo(productNum);	
			}
			
		    if (productInfo == null) {
		        return null;
		    }
			
			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("productNum", productInfo.getProductNum());
			
			int reviewCount = reviewService.getDataCount(paramMap);
			
			productInfo.setReviewCount(reviewCount);
			
			if(memberId != -1) {
				// 회원의 찜 여부
				paramMap.put("memberId", memberId);
				productInfo.setUserWish(wishService.findByWishId(paramMap) == null ? 0 : 1);
			}
			
		} catch (Exception e) {
			log.info("getProductWithDetails : ", e);
		}
		
		return productInfo;
	}
	
	@Override
	public List<Product> getProducts(Map<String, Object> map) {
		List<Product> list = new ArrayList<>();						
		
		try {
			Integer classifyCode = (Integer)map.get("classifyCode");

			switch (classifyCode) {
				case null: 
					list = getAllProductList(map); break;
				case 100: 
					list = getProductList(map); break;
				case 200: 
					list = getRescuedProductList(map); break;
				default:
					return null;
			}
			
		} catch (Exception e) {
			log.info("getProducts : ", e);
		}
		
		return list;
	}
	
	@Override
	public List<Product> getProductList(Map<String, Object> map) {
		List<Product> list = new ArrayList<>();						
		
		try {
			list = mapper.getProductList(map); 
			for(Product dto : list) {
				applyDiscount(dto);																					
			}
		} catch (Exception e) {
			log.info("getProductList : ", e);
		}
		
		return list;
	}
	
	@Override
	public List<Product> getRescuedProductList(Map<String, Object> map) {
		List<Product> list = null;
		
		try {
			list = mapper.getRescuedProductList(map);
			for(Product dto : list) {
				applyDiscount(dto);																					
			}				
		} catch (Exception e) {
			log.info("getRescuedProductList : ", e);
		}
		
		return list;
	}
	
	@Override
	public List<Product> getAllProductList(Map<String, Object> map) {
		List<Product> list = null;
		
		try {
			list = mapper.getAllProductList(map);
			for(Product dto : list) {
				applyDiscount(dto);																					
			}				
		} catch (Exception e) {
			log.info("getAllProductList : ", e);
		}
		
		return list;
	}
	
	
	
	/**
	 * 상품 할인가격 계산 및 적용
	 * @param product 상품 DTO
	 */
	private void applyDiscount(Product product) {
		if (product.getDiscountRate() > 0) {
			int discountedPrice = (int)(product.getUnitPrice() * (1 - (product.getDiscountRate() / 100.0)));
			
			product.setDiscountedPrice(discountedPrice);
		}						
	}

	@Override
	public Product getProductInfo(long productNum) {
		Product dto = null;
		
		try {
			dto = mapper.getProductInfo(productNum);
			
			applyDiscount(dto);
		} catch (Exception e) {
			log.info("getProductInfo : ", e);
		}
		
		return dto;
	}

	@Override
	public Product getRescuedProductInfo(long productNum) {
		Product dto = null;
		
		try {
			dto = mapper.getRescuedProductInfo(productNum);
			
			applyDiscount(dto);
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

	@Override
	public int getDataCount(int productClassification) {
		int result = 0;
		
		try {
			result = mapper.getDataCount(productClassification);
		} catch (Exception e) {
			log.info("getDataCount : ", e);
		}
		
		return result;
	}
	
	@Override
	public int getAllDataCount() {
		int result = 0;
		
		try {
			result = mapper.getAllDataCount();
		} catch (Exception e) {
			log.info("getAllDataCount : ", e);
		}
		
		return result;
	}




}
