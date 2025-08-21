package com.sp.app.admin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.InquiryManage;

@Mapper
public interface InquiryManageMapper {
	public int inquiryCount(Map<String, Object> map);
	public List<InquiryManage> listInquiry(Map<String, Object> map);
}
