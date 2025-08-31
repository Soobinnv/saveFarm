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

	@Override
	public InquiryManage findById(long inquiryNum) {
		InquiryManage dto = null;

		try {
			dto = mapper.findById(inquiryNum);
		} catch (Exception e) {
			log.info("findById : ", e);
		}

		return dto;
	}

	@Override
	public InquiryManage findByPrev(Map<String, Object> map) {
		InquiryManage dto = null;

		try {
			dto = mapper.findByPrev(map);
		} catch (Exception e) {
			log.info("findByPrev : ", e);
		}

		return dto;
	}

	@Override
	public InquiryManage findByNext(Map<String, Object> map) {
		InquiryManage dto = null;

		try {
			dto = mapper.findByNext(map);
		} catch (Exception e) {
			log.info("findByNext : ", e);
		}

		return dto;
	}

	@Override
	public void updateAnswer(InquiryManage dto) throws Exception {
		try {
			mapper.updateAnswer(dto);
		} catch (Exception e) {
			log.info("updateAnswer : ", e);
			
			throw e;
		}
		
	}

	@Override
	public void deleteAnswer(long inquiryNum) throws Exception {
		try {
			mapper.deleteAnswer(inquiryNum);
		} catch (Exception e) {
			log.info("deleteAnswer : ", e);
			
			throw e;
		}
		
	}

	@Override
	public void deleteInquiry(long inquiryNum) throws Exception {
		try {
			mapper.deleteInquiry(inquiryNum);
		} catch (Exception e) {
			log.info("deleteInquiry : ", e);
			
			throw e;
		}
		
	}

}
