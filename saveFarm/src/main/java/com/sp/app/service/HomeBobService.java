package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.HomeBob;

public interface HomeBobService {
	public void insertHomeBob(HomeBob dto, String uploadPath) throws Exception;
	public void updateHomeBob(HomeBob dto, String uploadPath) throws Exception;
	public void deleteHomeBob(long num, String uploadPath) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public List<HomeBob> listHomeBob(Map<String, Object> map);
	
	public HomeBob findById(long num);
	public HomeBob findByPrev(Map<String, Object> map);
	public HomeBob findByNext(Map<String, Object> map);
	
	public HomeBob findByFileId(long fileNum);

	public List<HomeBob> listHomeBobFile(long num);
	public void deleteHomeBobFile(Map<String, Object> map) throws Exception;
	public boolean deleteUploadFile(String uploadPath, String filename);
}
