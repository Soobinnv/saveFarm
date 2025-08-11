package com.sp.app.controller;


import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
	
	@PostMapping("saveCart")
	public String saveCart(Order dto, HttpSession session) throws Exception {
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			dto.setMemberId(info.getMemberId());
			
			service.insertCart(dto);
			
		} catch (Exception e) {
		}
		
		return "redirect:/myShoppint/cart";
	}
	
}


