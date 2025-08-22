package com.sp.app.admin.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.admin.mapper.FaqManageMapper;
import com.sp.app.admin.model.FaqManage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class FaqManageServiceImpl implements FaqManageService{
	private final FaqManageMapper mapper; 
	@Override
	public FaqManage dataCount(Map<String, Object> map) {
		FaqManage dto = null;
		
		try {
			dto = mapper.dataCount(map);
		} catch (Exception e) {
			log.info("dataCount 문제: ", e);
		}
		
		return dto;
	}

	@Override
	public List<FaqManage> categoryFAQList() {
		List<FaqManage> list = null;
		
		try {
			list = mapper.categoryFAQList();
		} catch (Exception e) {
			log.info("categoryFAQList 문제: ", e);
		}
		
		return list;
	}

	@Override
	public List<FaqManage> categoryList(Map<String, Object> map) {
		List<FaqManage> list = null;
		try {
			list = mapper.categoryList(map);
		} catch (Exception e) {
			log.info("categoryList 문제: ", e);
		}
		return list;
	}

	@Override
	public FaqManage findById(long faqNum) {
		FaqManage dto = null;
		
		try {
			
		} catch (Exception e) {
			log.info("categoryList 문제: ", e);
		}
		
		
		return dto;
	}

	@Override
	public void insertFAQ(FaqManage dto) throws SQLException {
		try {
			mapper.insertFAQ(dto);
		} catch (Exception e) {
			log.info("insertFAQ 문제: ", e);
		}
		
	}

	@Override
	public void updateFAQ(FaqManage dto) throws SQLException {
		try {
			mapper.updateFAQ(dto);
		} catch (Exception e) {
			log.info("insertFAQ 문제: ", e);
		}
		
	}

	@Override
	public void deleteFAQ(long faqNum) throws SQLException {
		try {
			mapper.deleteFAQ(faqNum);
		} catch (Exception e) {
			log.info("insertFAQ 문제: ", e);
		}
		
	}

}
