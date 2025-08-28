package com.sp.app.farm.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.farm.model.Inquiry;

@Mapper
public interface InquiryMapper {
	public void insertInquiry(Inquiry dto) throws SQLException;
	public void deleteInquiry(long inquiryNum) throws SQLException;
	
	public int dataCount(Map<String, Object> map);
	public List<Inquiry> listInquiry(Map<String, Object> map);
	
	public Inquiry findById(long inquiryNum);
	public Inquiry findByPrev(Map<String, Object> map);
	public Inquiry findByNext(Map<String, Object> map);
}
