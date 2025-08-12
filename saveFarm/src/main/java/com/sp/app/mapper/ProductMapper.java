package com.sp.app.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Product;

@Mapper
public interface ProductMapper {
	public List<Product> getProductList(Map<String, Object> map);	
	public List<Product> getRescuedProductList(Map<String, Object> map);	
	public Product getProductInfo(long productNum);	
	public Product getRescuedProductInfo(long productNum);	
	public List<Product> getProductImageList(long productNum);	
}
