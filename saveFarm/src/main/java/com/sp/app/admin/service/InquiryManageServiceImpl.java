package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.admin.mapper.InquiryManageMapper;
import com.sp.app.admin.model.InquiryManage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class InquiryManageServiceImpl implements InquiryManageService {
	private final InquiryManageMapper mapper;
	
	@Override
	public int inquiryCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = mapper.inquiryCount(map);
		} catch (Exception e) {
			log.info("inquiryCount : ", e);
		}
		return result;
	}

	@Override
	public List<InquiryManage> listInquiry(Map<String, Object> map) {
		List<InquiryManage> list = null;
		
		try {
			list = mapper.listInquiry(map);
		} catch (Exception e) {
			log.info("listMember : ", e);
		}
		
		return list;
	}

}
