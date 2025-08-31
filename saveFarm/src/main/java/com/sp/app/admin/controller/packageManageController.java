package com.sp.app.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.admin.model.PackageManage;
import com.sp.app.admin.service.PackageManageService;
import com.sp.app.common.MyUtil;
import com.sp.app.common.PaginateUtil;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/admin/package/*")
public class packageManageController {
	private final PackageManageService service;
	private final PaginateUtil paginateUtil;
	private final MyUtil myUtil;
	
	
	@GetMapping("list")
	public String handlePackageList(
			@RequestParam(name = "schType", defaultValue = "all") String schType,
    	    @RequestParam(name = "kwd", defaultValue = "") String kwd,
    	    @RequestParam(name = "schTypeModal", defaultValue = "all") String schTypeModal,
    	    @RequestParam(name = "kwdModal", defaultValue = "") String kwdModal,
    	    HttpServletRequest req,
			Model model) {
		
        int dataCount = 0;
        
        Map<String, Object> map = new HashMap<>();
        map.put("schType", schType);
        map.put("kwd", kwd);
        
        dataCount = service.dataCount(map);
        
        List<PackageManage> list = service.packageList(map);

        model.addAttribute("list", list);
        model.addAttribute("dataCount", dataCount);
		
		return "admin/package/list";
	}
	
	@PostMapping("packageProduct")
	public String packageProduct (@RequestParam (name = "packageNum") long packageNum,Model model) {
		
		
		List<PackageManage> list = service.productList(packageNum);
		model.addAttribute("list", list);
		model.addAttribute("packageNum", packageNum); 
		
		return "admin/package/details";
	}
	
	
	@PostMapping("details")
	public String handlePackageDetails(
			HttpServletRequest req,
			@RequestParam("packageNum") long packageNum,
			Model model) {
		
		
		List<PackageManage> list = service.modalpackageList();
		
		model.addAttribute("list", list);
		model.addAttribute("packageNum", packageNum);
		return "admin/package/details";
	}
	
	@GetMapping("memberList")
	public String handleMemberList(Model model) {
		
		return "admin/package/memberList";
	}
	
	@GetMapping("review")
	public String handleReview(Model model) {
		
		return "admin/package/review";
	}
}
