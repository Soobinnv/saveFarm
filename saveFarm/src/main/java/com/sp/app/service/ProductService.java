package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.Product;

public interface ProductService {
	public List<Product> getProductList(Map<String, Object> map);	
	public List<Product> getRescuedProductList(Map<String, Object> map);	
	public Product getProductInfo(long productNum);	
	public Product getRescuedProductInfo(long productNum);	
	public List<Product> getProductImageList(long productNum);	
}
