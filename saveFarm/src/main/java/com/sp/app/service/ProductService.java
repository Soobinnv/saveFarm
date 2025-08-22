package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.Product;

public interface ProductService {
	public Product getProductWithDetails(long productNum, int classifyCode, long memberId) throws Exception;	

	public List<Product> getProductList(Map<String, Object> map);	
	public List<Product> getRescuedProductList(Map<String, Object> map);	
	public List<Product> getAllProductList(Map<String, Object> map);
	
	public Product getProductInfo(long productNum);	
	public Product getRescuedProductInfo(long productNum);	
	
	public List<Product> getProductImageList(long productNum);	
	
	public int getDataCount(int productClassification);
	public int getAllDataCount();
	
	public void insertProduct(Product dto, String uploadPath) throws Exception;
	public void insertProductDetail(Product dto) throws Exception;
	public void insertRescuedProduct(Product dto, String uploadPath) throws Exception;
	
	public void updateProduct(Product dto, String uploadPath) throws Exception;
	public void updateProductDetail(Product dto) throws Exception;
	public void updateRescuedProduct(Product dto, String uploadPath) throws Exception;
	
	public void deleteProduct(long productNum, String uploadPath) throws Exception;
	public boolean deleteProductImageFile(String uploadPath, String filename);	
}
