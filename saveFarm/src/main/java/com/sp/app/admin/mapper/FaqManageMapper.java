package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.FaqManage;

@Mapper
public interface FaqManageMapper {
	public FaqManage dataCount(Map<String, Object> map);
	public List<FaqManage> categoryFAQList();
	public List<FaqManage> faqList(Map<String, Object> map);
	
	public FaqManage findById(long faqNum);
	
	public void insertFAQ(FaqManage dto) throws SQLException;
	public void updateFAQ(FaqManage dto) throws SQLException;
	public void deleteFAQ(long faqNum) throws SQLException;
}
