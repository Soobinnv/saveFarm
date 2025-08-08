package com.sp.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/product/")
public class ProductController {

	@GetMapping("list")
	public String list(Model model) {
		
		return "product/list";
	}
	
	@GetMapping("{productNum}")
	public String productDetail(
			@PathVariable("productNum") long productNum,
			HttpSession session, 
			Model model
		) throws Exception {
		
		try {
			
		} catch (Exception e) {
			log.info("productDetail : ", e);
		}
		
		return "product/detail";
	}
	
	
}
