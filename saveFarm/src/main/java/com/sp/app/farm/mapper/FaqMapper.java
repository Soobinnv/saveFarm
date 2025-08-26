package com.sp.app.farm.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.farm.model.Faq;


@Mapper
public interface FaqMapper {
	public Faq dataCount(Map<String, Object> map);
	public List<Faq> categoryFAQList();
	public List<Faq> faqList(Map<String, Object> map);
	
	public Faq findById(long faqNum);
}

