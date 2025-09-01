package com.sp.app.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.common.StorageService;
import com.sp.app.exception.StorageException;
import com.sp.app.farm.mapper.SupplyMapper;
import com.sp.app.farm.mapper.VarietyMapper;
import com.sp.app.farm.model.Variety;
import com.sp.app.mapper.ProductMapper;
import com.sp.app.model.Product;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ProductServiceImpl implements ProductService {
	private final ProductMapper mapper;
	private final SupplyMapper supplyMapper;
	private final VarietyMapper varietyMapper;
	private final ProductReviewService reviewService;
	private final WishService wishService;
	private final StorageService storageService;
	
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
			paramMap.put("reviewBlock", 0);
			
			int reviewCount = reviewService.getDataCount(paramMap);
			
			productInfo.setReviewCount(reviewCount);
			
			if(memberId != -1) {
				// 회원의 찜 여부
				paramMap.put("memberId", memberId);
				productInfo.setUserWish(wishService.findByWishId(paramMap) == null ? 0 : 1);
			}
			
		} catch (Exception e) {
			log.info("getProductWithDetails : ", e);
			throw e;
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
	public Product getProductAllInfo(long productNum) {
		Product dto = null;
		
		try {
			dto = mapper.getProductAllInfo(productNum);
			
			applyDiscount(dto);
		} catch (Exception e) {
			log.info("getProductAllInfo : ", e);
		}
		
		return dto;
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

	@Transactional
	@Override
	public void insertProduct(Product dto, String uploadPath) throws Exception {
		try {
			String filename = storageService.uploadFileToServer(dto.getMainImage(), uploadPath);
			dto.setMainImageFilename(filename);
			
			mapper.insertProduct(dto);
			
			// 추가 이미지 저장
			if(! dto.getSubImages().isEmpty()) {
				insertProductFile(dto, uploadPath);
			}
			
		} catch (Exception e) {
			log.info("insertProduct : ", e);
			throw e;
		}
		
	}

	private void insertProductFile(Product dto, String uploadPath) throws Exception {
		for (MultipartFile mf : dto.getSubImages()) {
			try {
				String saveFilename = Objects.requireNonNull(storageService.uploadFileToServer(mf, uploadPath));
				dto.setProductImageFilename(saveFilename);
				
				mapper.insertProductImage(dto);
			} catch (NullPointerException e) {
			} catch (StorageException e) {
			} catch (Exception e) {
				throw e;
			}
		}
	}
	
	@Override
	public void insertProductDetail(Product dto) throws Exception {
		try {
			mapper.insertProductDetail(dto);
		} catch (Exception e) {
			log.info("insertProductDetail : ", e);
			throw e;
		}
	}

	@Override
	public void insertRescuedProduct(Product dto, String uploadPath) throws Exception {
		try {
			mapper.insertRescuedProduct(dto);
		} catch (Exception e) {
			log.info("insertRescuedProduct : ", e);
		}
	}

	@Transactional
	@Override
	public void updateProduct(Product dto, String uploadPath) throws Exception {
		try {
			String filename = storageService.uploadFileToServer(dto.getMainImage(), uploadPath);
			if(filename != null) {
				// 이전 파일 지우기
				if (! dto.getMainImageFilename().isBlank()) {
					deleteUploadFile(uploadPath, dto.getMainImageFilename());
				}
				
				dto.setMainImageFilename(filename);
			}
			
			mapper.updateProduct(dto);
			
			// 추가 이미지
			if(! dto.getSubImages().isEmpty()) {
				insertProductFile(dto, uploadPath);
			}
			
		} catch (Exception e) {
			log.info("updateProduct : ", e);
			throw e;
		}
		
	}
	
	public boolean deleteUploadFile(String uploadPath, String filename) {
		return storageService.deleteFile(uploadPath, filename);
	}
	
	@Transactional
	@Override
	public void updateProductDetail(Product dto, List<Long> supplyNums) throws Exception {
		try {
			// 판매 상품 재고 등록
			mapper.updateProductDetail(dto);
			
			if(supplyNums != null && supplyNums.size() != 0) {
				Map<String, Object> paramMap = new HashMap<>();
				
				// 납품 목록 처리
				// 납품 상태: 납품 완료 -> 재고 추가 상태로 변경
				// 납품 - 상품 번호: 상품 재고 추가 시 번호 등록 
				paramMap.put("state", 6);
				
				for(long supplyNum : supplyNums) {
					paramMap.put("supplyNum", supplyNum);
					paramMap.put("productNum", dto.getProductNum());
					supplyMapper.updateState1(paramMap);									
				}				
			}
			
		} catch (Exception e) {
			log.info("updateProductDetail : ", e);
			throw e;
		}
	}

	@Override
	public void updateRescuedProduct(Product dto, String uploadPath) throws Exception {
		try {
			mapper.updateRescuedProduct(dto);
		} catch (Exception e) {
			log.info("updateRescuedProduct : ", e);
			throw e;
		}
	}

	@Transactional
	@Override
	public void deleteProduct(long productNum, String uploadPath) throws Exception {
		try {
			Product dto = getProductInfo(productNum);
			
			String filename = storageService.uploadFileToServer(dto.getMainImage(), uploadPath);
			if(filename != null) {
				// 파일 지우기
				if (! dto.getMainImageFilename().isBlank()) {
					deleteUploadFile(uploadPath, dto.getMainImageFilename());
				}
			}
			
			mapper.deleteProduct(productNum);
			mapper.deleteProductImage(productNum);
			
		} catch (Exception e) {
			log.info("deleteProduct : ", e);
			throw e;
		}
	}

	@Override
	public int getDataCount(Integer productClassification) {
		int result = 0;
		
		try {
			result = mapper.getDataCount(productClassification);
		} catch (Exception e) {
			log.info("getDataCount : ", e);
		}
		
		return result;
	}

	@Transactional
	@Override
	public void updateProductWithDetails(Product dto, String uploadPath) throws Exception {
		try {
			updateProduct(dto, uploadPath);
			
	        updateProductDetail(dto, null);
		} catch (Exception e) {
			log.info("updateProductWithDetails : ", e);
			throw e;
		}
	}

	@Transactional
	@Override
	public void insertProductWithDetails(Product dto, String uploadPath) throws Exception {
		try {
			insertProduct(dto, uploadPath);
			insertProductDetail(dto);
			
			if(dto.getFarmNum() != 0) {
				insertRescuedProduct(dto, null);				
			}
			
		} catch (Exception e) {
			log.info("insertProductWithDetails : ", e);
			throw e;
		}
	}

	@Override
	public List<Variety> getVarietyList() {
		List<Variety> list = null;
		
		try {
			list = varietyMapper.listAll();
		} catch (Exception e) {
			log.info("getVarietyList : ", e);
		}
		
		return list;
	}

}
