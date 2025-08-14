package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.ProductQna;

public interface ProductQnaService {
	public void insertQna(ProductQna dto) throws Exception;
	public void updateQna(ProductQna dto) throws Exception;
	public void deleteQna(long qnaNum) throws Exception;
	
	public List<ProductQna> getQnaList(Map<String, Object> map);
	public List<ProductQna> getMyQnaList(Map<String, Object> map);
	public int getDataCount(Map<String, Object> map);
	public int getMyQnaDataCount(long memberId);
}
