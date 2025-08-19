package com.sp.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.sp.app.common.PaginateUtil;
import com.sp.app.service.MyPageService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class MyPageController {
	private final MyPageService service;
	private final PaginateUtil paginateUtil;
	
	@GetMapping("/myPage")
	public String handleMyPage(Model model) {
		
		return "myPage/myPage";
	}
	
}
