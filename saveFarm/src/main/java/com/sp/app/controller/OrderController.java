package com.sp.app.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.service.MemberService;
import com.sp.app.service.MyShoppingService;
import com.sp.app.service.OrderService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/order/*")
public class OrderController {
	private final OrderService orderService;
	private final MemberService memberService;
	private final MyShoppingService myShoppingService;

	@RequestMapping(name = "payment", method = {RequestMethod.GET, RequestMethod.POST})
	public String paymentForm(
			@RequestParam(name = "productNums") List<Long> productNums, 
			@RequestParam(name = "buyQtys") List<Integer> butQtys, 
			@RequestParam(name = "mode", defaultValue = "buy") String mode, 
			Model model, 
			HttpSession session) throws Exception {
		
		try {
			
			return "order/payment";
		} catch (Exception e) {
			log.info("paymentForm : ", e);
		}
		
		return "redirect:/";
	}
	
	
}
