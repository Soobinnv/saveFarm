package com.sp.app.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.ProductQna;

@Mapper
public interface ProductQnaMapper {
	public void insertQna(ProductQna dto) throws Exception;
	public void updateQna(ProductQna dto) throws Exception;
	public void deleteQna(long num) throws Exception;
	
	public List<ProductQna> getQnaList(Map<String, Object> map);
}
