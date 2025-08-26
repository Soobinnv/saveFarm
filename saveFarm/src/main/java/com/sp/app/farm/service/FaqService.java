package com.sp.app.farm.service;

import java.util.List;
import java.util.Map;

import com.sp.app.farm.model.Faq;


public interface FaqService {
	public Faq dataCount(Map<String, Object> map);
	public List<Faq> categoryFAQList();
	public List<Faq> faqList(Map<String, Object> map);
	
	public Faq findById(long faqNum);
}

