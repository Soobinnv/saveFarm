package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Product;

@Mapper
public interface ProductMapper {
	public List<Product> getProductList(Map<String, Object> map);	
	public List<Product> getRescuedProductList(Map<String, Object> map);	
	public List<Product> getAllProductList(Map<String, Object> map);	
	public Product getProductInfo(long productNum);	
	public Product getRescuedProductInfo(long productNum);	
	public List<Product> getProductImageList(long productNum);	
	
	public void insertProduct(Product dto) throws SQLException;
	public void insertProductDetail(Product dto) throws SQLException;
	public void insertRescuedProduct(Product dto) throws SQLException;
	public void insertProductImage(List<Product> list) throws SQLException;
	
	public void updateProduct(Product dto) throws SQLException;
	public void updateProductDetail(Product dto) throws SQLException;
	public void updateRescuedProduct(Product dto) throws SQLException;
	
	public void deleteProduct(long productNum) throws SQLException;
	public void deleteProductImage(long productImageNum) throws SQLException;
}
