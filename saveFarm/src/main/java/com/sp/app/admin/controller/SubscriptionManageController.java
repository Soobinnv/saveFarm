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
@RequestMapping("/admin/Subscription/*")
public class SubscriptionManageController {
	
	@GetMapping("package")
	public String handlePackage(Model model) {
		
		
		return "admin/Subscription/package";
	}
	
	@GetMapping("memberList")
	public String handleMemberList(Model model) {
		
		
		return "admin/Subscription/memberList";
	}
	
	@GetMapping("review")
	public String handleReview(Model model) {
		
		
		return "admin/Subscription/review";
	}
	
}
