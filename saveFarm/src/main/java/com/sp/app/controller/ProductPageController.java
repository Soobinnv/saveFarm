package com.sp.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sp.app.model.Product;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.ProductService;
import com.sp.app.service.WishService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/products")
public class ProductPageController {

	private final ProductService service;
	private final WishService wishService;
	
	// 상품 리스트
	@GetMapping
	public String productList(Model model) {
		return "product/list";
	}
	
	// 상품 상세 페이지
	@GetMapping("/{productNum}")
	public String productInfo(
			@PathVariable("productNum") long productNum,
			HttpSession session, 
			Model model
		) throws Exception {
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			Product productInfo = Objects.requireNonNull(service.getProductInfo(productNum));

			if(info != null) {
				// 회원의 찜 여부
				Map<String, Object> map = new HashMap<>();
				map.put("memberId", info.getMemberId());
				map.put("productNum", productInfo.getProductNum());
				
				productInfo.setUserWish(wishService.findByWishId(map) == null ? 0 : 1);
			}
			
			List<Product> productImageList = service.getProductImageList(productNum);
			
			model.addAttribute("productInfo", productInfo);
			model.addAttribute("productImageList", productImageList);
			
			return "product/info";
			
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("productInfo : ", e);
		}

		return "redirect:/products";
	}
	

}
