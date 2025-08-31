package com.sp.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.UserInquiryMapper;
import com.sp.app.model.Inquiry;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Slf4j
@Service("userInquiryService")
public class InquiryServiceImpl implements InquiryService {
	private final UserInquiryMapper mapper;
	
	@Override
	public void insertInquiry(Inquiry dto) throws Exception {
		try {
			mapper.insertInquiry(dto);
		} catch (Exception e) {
			log.info("insertInquiry : ", e);
			
			throw e;
		}
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = mapper.dataCount(map);
		} catch (Exception e) {
			log.info("dataCount : ", e);
		}
		
		return result;
	}

	@Override
	public List<Inquiry> listInquiry(Map<String, Object> map) {
		List<Inquiry> list = null;

		try {
			list = mapper.listInquiry(map);
		} catch (Exception e) {
			log.info("listInquiry : ", e);
		}
		
		return list;
	}

	@Override
	public Inquiry findById(long inquiryNum) {
		Inquiry dto = null;

		try {
			dto = mapper.findById(inquiryNum);
		} catch (Exception e) {
			log.info("findById : ", e);
		}

		return dto;
	}
	
	@Override
	public Inquiry findByPrev(Map<String, Object> map) {
		Inquiry dto = null;

		try {
			dto = mapper.findByPrev(map);
		} catch (Exception e) {
			log.info("findById : ", e);
		}

		return dto;
	}
	
	@Override
	public Inquiry findByNext(Map<String, Object> map) {
		Inquiry dto = null;

		try {
			dto = mapper.findByNext(map);
		} catch (Exception e) {
			log.info("findById : ", e);
		}

		return dto;
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

	@Override
	public void updateInquiry(Inquiry dto) throws Exception {
		try {
			mapper.updateInquiry(dto);
		} catch (Exception e) {
			log.info("updateInquiry : ", e);
			
			throw e;
		}
		
	}	
}
