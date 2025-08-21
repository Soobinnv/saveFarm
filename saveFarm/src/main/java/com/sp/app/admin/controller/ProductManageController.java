package com.sp.app.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/admin/product/*")
public class ProductManageController {
	
	@GetMapping("list")
	public String handleProductList(Model model) {
		
		
		return "admin/product/list";
	}
	
	@GetMapping("farmProductList")
	public String handleProductFarmProductList(Model model) {
		
		
		return "admin/product/farmProductList";
	}
	
	@GetMapping("inquiry")
	public String handleProductInquiry(Model model) {
		
		
		return "admin/product/inquiry";
	}
	
	@GetMapping("review")
	public String handleProductReview(Model model) {
		
		
		return "admin/product/review";
	}
	
	
	
}
