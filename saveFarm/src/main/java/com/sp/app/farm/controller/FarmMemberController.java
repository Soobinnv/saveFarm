package com.sp.app.farm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping(value = "/farm/member/*")
public class FarmMemberController {

	@GetMapping("login")
	public String loginForm() {
		return "farm/member/login";
	}
	
	/*
	@PostMapping("login")
	public String loginSubmit() {
		return uri;
	}
	*/
	
	// public String logout()
}
