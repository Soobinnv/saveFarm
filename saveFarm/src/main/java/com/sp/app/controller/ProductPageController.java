package com.sp.app.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.model.Product;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.ProductService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/products")
public class ProductPageController {

	private final ProductService service;
	
	// 상품 리스트
	@GetMapping
	public String productList(Model model) {
		return "product/list";
	}
	
	// 상품 정보 페이지
	@GetMapping("/{productNum}")
	public String productInfo(
			@PathVariable("productNum") long productNum,
			@RequestParam(name = "classifyCode", required = false) int classifyCode,
			HttpSession session, 
			Model model
		) throws Exception {
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			long memberId = (info != null) ? info.getMemberId() : -1;
			
			Product productInfo = service.getProductWithDetails(productNum, classifyCode, memberId);
			
			if(productInfo == null) {
				return "redirect:/products";
			}
			
			List<Product> productImageList = service.getProductImageList(productNum);
			
			model.addAttribute("productInfo", productInfo);
			model.addAttribute("productImageList", productImageList);
			model.addAttribute("recommendList", null);
			
			return "product/info";
		} catch (Exception e) {
			log.info("productInfo : ", e);
		}

		return "redirect:/products";
	}
	
}
