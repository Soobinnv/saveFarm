package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.ProductQna;

public interface ProductQnaService {
	public void insertQna(ProductQna dto) throws Exception;
	public void updateQna(ProductQna dto) throws Exception;
	public void deleteQna(long num) throws Exception;
	
	public List<ProductQna> getQnaList(Map<String, Object> map);
	public int getDataCount(Map<String, Object> map);
}
