package com.sp.app.farm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class FarmHomeController {
	
	@GetMapping("/farm")
	public String handleHome(Model model) {
		
		return "farm/main/farmHome";
	}
	
	@GetMapping("/farm/guide")
	public String guide (Model model) {
		
		return "farm/guide/guidePage";
	}
	
	@GetMapping("/farm/register")
	public String register (Model model) {
		
		return "farm/register/registerMain";
	}
	
	@GetMapping("/farm/registerForm")
	public String registerFrom (Model model) {
		
		return "farm/register/registerWrite";
	}
	
	@GetMapping("/farm/registerList")
	public String registerList (Model model) {
		
		return "farm/register/registerList";
	}
	
	@GetMapping("/farm/login")
	public String loginForm () {
		
		return "farm/member/login";
	}
	
	@GetMapping("/farm/member")
	public String member (Model model) {
		
		return "farm/member/member";
	}
	
	@GetMapping("/farm/member/idFind")
	public String idFind (Model model) {
		
		return "farm/member/idFind";
	}
	
	@GetMapping("/farm/member/pwdFind")
	public String pwdFind (Model model) {
		
		return "farm/member/pwdFind";
	}
	
	@GetMapping("/farm/member/pwd")
	public String pwd (Model model) {
		
		return "farm/member/pwd";
	}
}
