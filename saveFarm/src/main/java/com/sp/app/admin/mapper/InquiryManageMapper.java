package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.InquiryManage;

@Mapper
public interface InquiryManageMapper {
	public int inquiryCount(Map<String, Object> map);
	public List<InquiryManage> listInquiry(Map<String, Object> map);
	
	
	public InquiryManage findById(long inquiryNum);
	public InquiryManage findByPrev(Map<String, Object> map);
	public InquiryManage findByNext(Map<String, Object> map);
	
	public void updateAnswer(InquiryManage dto) throws SQLException;
	public void deleteAnswer(long inquiryNum) throws SQLException;
	public void deleteInquiry(long inquiryNum) throws SQLException;
	
}
