package com.sp.app.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.model.Order;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.MyShoppingService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/myShopping/*")
public class MyShoppingController {
	private final MyShoppingService service;
	
	// 장바구니 리스트
	@GetMapping("cart")
	public String listCart(HttpSession session,
			Model model) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		List<Order> list = service.listCart(info.getMemberId());
		
		model.addAttribute("list", list);
		
		return "myShopping/cart";
	}
	
	// 장바구니 저장
	@PostMapping("saveCart")
	public String saveCart(Order dto, HttpSession session) throws Exception {
	    try {
	        SessionInfo info = (SessionInfo) session.getAttribute("member");

	        dto.setMemberId(info.getMemberId());

	        // 장바구니 저장
	        service.insertCart(dto);

	        // ★ 장바구니 개수 다시 조회 후 세션에 저장
	        int cartSize = service.getCartSize(info.getMemberId());
	        info.setCartSize(cartSize); // 세션 객체에 값 업데이트
	        session.setAttribute("member", info);

	    } catch (Exception e) {
	        log.info("saveCart error : ", e);
	    }

	    return "redirect:/myShopping/cart";
	}
	
	// 하나 상품 장바구니 비우기
	@GetMapping("deleteCart")
	public String deleteCart(
			@RequestParam(name = "productNum") long productNum, 
			HttpSession session) throws Exception {
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("gubun", "item");
			map.put("memberId", info.getMemberId());
			map.put("productNum", productNum);
			
			service.deleteCart(map);
			
		} catch (Exception e) {
			log.info("deleteCart : ", e);
		}
		return "redirect:/myShopping/cart";
	}
	
	// 선택상품 장바구니 비우기
	@PostMapping("deleteListCart")
	public String deleteListCart(
			@RequestParam(name = "nums") List<Long> nums, 
			HttpSession session) throws Exception {
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("gubun", "list");
			map.put("memberId", info.getMemberId());
			map.put("list", nums);
			
			service.deleteCart(map);
			
		} catch (Exception e) {
			log.info("deleteListCart : ", e);
		}
		return "redirect:/myShopping/cart";
	}
	
	// 장바구니 모두 비우기
	@GetMapping("deleteCartAll")
	public String deleteCartAll(HttpSession session) throws Exception {
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
		
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("gubun", "all");
			map.put("memberId", info.getMemberId());
			
			service.deleteCart(map);
			
		} catch (Exception e) {
			log.info("deleteCartAll : ", e);
		}
		
		return "redirect:/myShopping/cart";
	}
}


