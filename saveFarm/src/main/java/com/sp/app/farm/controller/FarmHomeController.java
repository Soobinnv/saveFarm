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
	
	@GetMapping("/farm/myFarm")
	public String myFarm (Model model) {
		
		return "farm/myFarm/myFarmMain";
	}
	
	@GetMapping("/farm/guide")
	public String guide (Model model) {
		
		return "farm/guide/guidePage";
	}
}
