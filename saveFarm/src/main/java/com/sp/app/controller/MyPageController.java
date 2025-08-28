package com.sp.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/myPage/*")
public class MyPageController {
	
	@GetMapping("/paymentList")
	public String getPayment(
			@RequestParam(name = "accessType", required = false, defaultValue = "myPage") String accessType,
			Model model
		) {
		
		model.addAttribute("accessType", accessType);
		
		return "myPage/paymentList";
	}
}
