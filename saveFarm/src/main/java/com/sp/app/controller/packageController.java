package com.sp.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/package/*")
public class packageController {
	
	@GetMapping("main")
	public String mainForm() {
		return "package/main";
	}
	
	@GetMapping("homepackage")
	public String homepackage(Model model) throws Exception{
		
		model.addAttribute("mode", "homePackage");
		
		return "package/packageCart";
	}
	
	
	@GetMapping("saladpackage")
	public String salpackage(Model model) throws Exception{
			
		model.addAttribute("mode", "saladPackage");
		return "package/packageCart";
	}
	
}
