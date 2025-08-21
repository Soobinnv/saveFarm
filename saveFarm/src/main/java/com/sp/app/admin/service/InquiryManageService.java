package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.InquiryManage;

public interface InquiryManageService {
	public int inquiryCount(Map<String, Object> map);
	public List<InquiryManage> listInquiry(Map<String, Object> map);
}
