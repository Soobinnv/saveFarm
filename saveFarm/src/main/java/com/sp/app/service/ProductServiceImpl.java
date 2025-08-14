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
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Product getRescuedProductInfo(long productNum) {
		// TODO Auto-generated method stub
		return null;
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
