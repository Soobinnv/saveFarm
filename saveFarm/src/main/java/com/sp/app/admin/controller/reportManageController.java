//package com.sp.app.admin.controller;
//
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//
//import com.sp.app.admin.service.FaqManageService;
//import com.sp.app.common.MyUtil;
//import com.sp.app.common.PaginateUtil;
//
//import lombok.RequiredArgsConstructor;
//import lombok.extern.slf4j.Slf4j;
//
//@Controller
//@RequiredArgsConstructor
//@Slf4j
//@RequestMapping("/admin/report/*")
//public class reportManageController {
//	private final FaqManageService service;
//    private final PaginateUtil paginateUtil;
//    private final MyUtil myUtil;
//    
//	@GetMapping("/")
//	public String handleReport(
//			@RequestParam(name = "status", defaultValue = "0") int status,
//			@RequestParam(name = "page", defaultValue = "1") int currentPage,
//			@RequestParam(name = "schType", defaultValue = "all") String schType,
//			@RequestParam(name = "kwd", defaultValue = "") String kwd,			
//			Model model) {
//		
//		model.addAttribute("reportsStatus", status);
//		model.addAttribute("page", currentPage);
//		model.addAttribute("schType", schType);
//		model.addAttribute("kwd", kwd);
//		
//		
//		return "admin/report/main";
//	}
//
//	@GetMapping("reportList/{menuItem}")
//	public String reportList(@PathVariable(name = "menuItem") String menuItem,
//			@RequestParam(name = "status", defaultValue = "0") int status,
//			@RequestParam(name = "pageNo", defaultValue = "1") int current_page,
//			@RequestParam(name = "schType", defaultValue = "all") String schType,
//			@RequestParam(name = "kwd", defaultValue = "") String kwd,			
//			Model model) {
//		
//		String viewPage = "listAll";
//		try {
//			viewPage = menuItem.equals("group") ? "listGroup" : viewPage;
//			
//			int size = 10; // 한 화면에 보여주는 게시물 수
//			int total_page = 0;
//			int dataCount = 0;
//
//			kwd = myUtil.decodeUrl(kwd);
//
//			Map<String, Object> map = new HashMap<String, Object>();
//			map.put("status", status);
//			map.put("schType", schType);
//			map.put("kwd", kwd);
//
//			if(menuItem.equals("all")) {
//				dataCount = service.dataCount(map);
//			} else {
//				dataCount = service.dataGroupCount(map);
//			}
//			if (dataCount != 0) {
//				total_page = paginateUtil.pageCount(dataCount, size);
//			}
//
//			current_page = Math.min(current_page, total_page);
//			
//			int offset = (current_page - 1) * size;
//			if(offset < 0) offset = 0;
//
//			map.put("offset", offset);
//			map.put("size", size);			
//			
//			List<Reports> list = null;
//			if(menuItem.equals("all")) {
//				list = service.listReports(map);
//			} else {
//				list = service.listGroupReports(map);
//			}
//
//			String paging = paginateUtil.pagingMethod(current_page, total_page, "listPage");
//			
//			model.addAttribute("list", list);
//			model.addAttribute("reportsStatus", status);
//			model.addAttribute("pageNo", current_page);
//			model.addAttribute("dataCount", dataCount);
//			model.addAttribute("size", size);
//			model.addAttribute("total_page", total_page);
//			model.addAttribute("paging", paging);
//
//		} catch (Exception e) {
//			log.info("list : ", e);
//		}
//		
//		return "admin/reportsManage/" + viewPage;
//	}
//}
