package com.sp.app.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.ProductQna;

@Mapper
public interface ProductQnaMapper {
	public void insertQna(ProductQna dto) throws Exception;
	public void updateQna(ProductQna dto) throws Exception;
	public void deleteQna(long qnaNum) throws Exception;
	
	public List<ProductQna> getQnaList(Map<String, Object> map);
	public List<ProductQna> getMyQnaList(Map<String, Object> map);
	public int getDataCount(Map<String, Object> map);
	public int getMyQnaDataCount(long memberId);
}
