package com.sp.app.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.model.Product;

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
	
	@GetMapping("info")
	// @GetMapping("{productNum}")
	public String productInfo(
			// @PathVariable("productNum") long productNum,
			HttpSession session, 
			Model model
		) throws Exception {
		
		try {
			
		} catch (Exception e) {
			log.info("productDetail : ", e);
		}
		
		return "product/info";
	}
	
	// 상품 설명 - AJAX-JSON
	@GetMapping("{productNum}/productDesc")
	@ResponseBody
	public List<Product> getProductDesc(@PathVariable("productNum") long productNum) {
		
		return null;
	}
	
	// 상품 문의 - AJAX-JSON
	@GetMapping("{productNum}/productQna")
	@ResponseBody
	public List<Product> getProductQna(@PathVariable("productNum") long productNum) {
		
		return null;
	}
	
	// 상품 환물/반품 - AJAX-JSON
	@GetMapping("{productNum}/productRefund")
	@ResponseBody
	public List<Product> getProductRefund(@PathVariable("productNum") long productNum) {
		
		return null;
	}
	
	// 상품 리뷰 - AJAX-JSON
	@GetMapping("{productNum}/productReview")
	@ResponseBody
	public List<Product> getProductReview() {
		
		return null;
	}
	
	
	
}
