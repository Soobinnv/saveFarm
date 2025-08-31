package com.sp.app.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Inquiry;

@Mapper
public interface UserInquiryMapper {
	public void insertInquiry(Inquiry dto) throws Exception;
	public void updateInquiry(Inquiry dto) throws Exception;
	public void deleteInquiry(long inquiryNum) throws Exception;
	
	public Inquiry findById(long inquiryNum);

	public Inquiry findByPrev(Map<String, Object> map);
	public Inquiry findByNext(Map<String, Object> map);

	public List<Inquiry> listInquiry(Map<String, Object> map);
	
	public int dataCount(Map<String, Object> map);
	public int getMyInquiryDataCount(long memberId);
}
