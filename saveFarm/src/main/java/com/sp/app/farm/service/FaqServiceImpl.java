package com.sp.app.farm.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.farm.mapper.FaqMapper;
import com.sp.app.farm.model.Faq;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class FaqServiceImpl implements FaqService {
	private final FaqMapper mapper;

	@Override
	public Faq dataCount(Map<String, Object> map) {
		Faq dto = null;
		try {
			dto = mapper.dataCount(map);
		} catch (Exception e) {
			log.info("dataCount : ", e);
		}
		return dto;
	}

	@Override
	public List<Faq> categoryFAQList() {
		List<Faq> list = null;
		
		try {
			list = mapper.categoryFAQList();
		} catch (Exception e) {
			log.info("listFindFarm : ", e);
		}
		
		return list;
	}

	@Override
	public List<Faq> faqList(Map<String, Object> map) {
		List<Faq> list = null;
		
		try {
			list = mapper.faqList(map);
		} catch (Exception e) {
			log.info("faqList : ", e);
		}
		
		return list;
	}

	@Override
	public Faq findById(long faqNum) {
		Faq dto = null;
		try {
			dto = mapper.findById(faqNum);
		} catch (Exception e) {
			log.info("findById : ", e);
		}
		return dto;
	}
	
	

}
