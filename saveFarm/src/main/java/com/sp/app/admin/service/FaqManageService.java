package com.sp.app.admin.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.FaqManage;

public interface FaqManageService {
	public FaqManage dataCount(Map<String, Object> map);
	public List<FaqManage> categoryFAQList();
	public List<FaqManage> faqList(Map<String, Object> map);
	
	public FaqManage findById(long faqNum);
	
	public void insertFAQ(FaqManage dto) throws SQLException;
	public void updateFAQ(FaqManage dto) throws SQLException;
	public void deleteFAQ(long faqNum) throws SQLException;
}
