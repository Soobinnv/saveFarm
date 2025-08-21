package com.sp.app.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/admin/order/*")
public class OrderManageContorller {
	
	@GetMapping("orderList/{itemId}") /* /{itemId} */
	public String headleOrderList(
			@PathVariable("itemId") int itemId,
			Model model) throws Exception {
		
		return "admin/order/orderList";
	}
	@GetMapping("orderDetailList/{itemId}") /* /{itemId} */
	public String headleOrderDetailList(
			@PathVariable("itemId") int itemId,
			Model model) throws Exception {
		
		return "admin/order/orderDetailList";
	}
	
	
}
