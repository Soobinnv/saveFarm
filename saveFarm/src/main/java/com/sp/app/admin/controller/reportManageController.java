package com.sp.app.admin.controller;

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
@RequestMapping("/admin/report/*")
public class reportManageController {
	
	@GetMapping("/")
	public String handleReport(
			@RequestParam(name = "status", defaultValue = "0") int status,
			@RequestParam(name = "page", defaultValue = "1") int currentPage,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,			
			Model model) {
		
		model.addAttribute("reportsStatus", status);
		model.addAttribute("page", currentPage);
		model.addAttribute("schType", schType);
		model.addAttribute("kwd", kwd);
		
		
		return "admin/report/report";
	}
}
