package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.Return;

public interface ReturnService {
	public void insertReturn(Return dto, String uploadPath) throws Exception;
	public void updateReturn(Return dto, String uploadPath) throws Exception;
	public void deleteReturn(long returnNum, String uploadPath) throws Exception;
	public boolean deleteReturnImageFile(String uploadPath, String filename);
	
	public List<Return> getReturnList(Map<String, Object> map);	
	public List<Return> getMyReturnList(Map<String, Object> map);	
	public int getDataCount(Map<String, Object> map);
	public int getMyReturnDataCount(long memberId);
}
