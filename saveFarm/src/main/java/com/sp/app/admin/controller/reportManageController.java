//package com.sp.app.admin.controller;
//
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//import java.util.Objects;
//
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//
//import com.sp.app.common.MyUtil;
//import com.sp.app.common.PaginateUtil;
//import com.sp.app.model.Reports;
//import com.sp.app.model.SessionInfo;
//import com.sp.app.service.ReportService;
//
//import jakarta.servlet.http.HttpSession;
//import lombok.RequiredArgsConstructor;
//import lombok.extern.slf4j.Slf4j;
//
//@Controller
//@RequiredArgsConstructor
//@Slf4j
//@RequestMapping("/admin/reportsManage/*")
//public class reportManageController {
//	private final ReportService service;
//	private final PaginateUtil paginateUtil;
//	private final MyUtil myUtil;
//	
//	@GetMapping("main")
//	public String main(@RequestParam(name = "status", defaultValue = "0") int status,
//			@RequestParam(name = "page", defaultValue = "1") int current_page,
//			@RequestParam(name = "schType", defaultValue = "all") String schType,
//			@RequestParam(name = "kwd", defaultValue = "") String kwd,			
//			Model model) {
//
//		model.addAttribute("reportsStatus", status);
//		model.addAttribute("page", current_page);
//		model.addAttribute("schType", schType);
//		model.addAttribute("kwd", kwd);
//		
//		return "admin/report/main";
//	}
//	
//	// AJAX - Text
//	@GetMapping("list/{menuItem}")
//	public String list(@PathVariable(name = "menuItem") String menuItem,
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
//		return "admin/report/" + viewPage;
//	}
//
//	// AJAX - Text
//	@GetMapping("listRelated")
//	public String listRelated(
//			@RequestParam(name = "num") long num,
//			@RequestParam(name = "target_num") long target_num,
//			@RequestParam(name = "target") String target,
//			@RequestParam(name = "pageNo", defaultValue = "1") int current_page,
//			Model model) {
//		
//		try {
//			int size = 5;
//			int total_page = 0;
//			int dataCount = 0;
//
//			Map<String, Object> map = new HashMap<String, Object>();
//			map.put("num", num);
//			map.put("target_num", target_num);
//			map.put("target", target);
//
//			dataCount = service.dataRelatedCount(map);
//
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
//			List<Reports> list = service.listRelatedReports(map);
//
//			String paging = paginateUtil.pagingMethod(current_page, total_page, "listPage");
//			
//			model.addAttribute("list", list);
//			model.addAttribute("pageNo", current_page);
//			model.addAttribute("dataCount", dataCount);
//			model.addAttribute("size", size);
//			model.addAttribute("total_page", total_page);
//			model.addAttribute("paging", paging);
//
//		} catch (Exception e) {
//			log.info("listRelated : ", e);
//		}
//		
//		return "admin/report/listAll";
//	}
//	
//	@GetMapping("article/{num}")
//	public String article(@PathVariable(name = "num") long num,
//			@RequestParam(name = "status", defaultValue = "0") int status,			
//			@RequestParam(name = "page") String page,
//			@RequestParam(name = "schType", defaultValue = "all") String schType,
//			@RequestParam(name = "kwd", defaultValue = "") String kwd,
//			Model model) throws Exception {
//
//		String query = "page=" + page;
//		try {
//			kwd = myUtil.decodeUrl(kwd);
//
//			if(status != 0) {
//				query += "&status=" + status;
//			}
//			if (! kwd.isBlank()) {
//				query += "&schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
//			}
//
//			Reports report = Objects.requireNonNull(service.findById(num));
//			if(report.getHandlingNote() != null) {
//				report.setHandlingNote(report.getHandlingNote().replaceAll("\n", "<br>"));
//			}
//			
//			// 대상 게시글 신고건수
//			Map<String, Object> countMap = new HashMap<>();
//			countMap.put("target", report.getTargetTable());
//			countMap.put("target_num", report.getTargetNum());
//			int reportsCount = service.dataRelatedCount(countMap);
//			
//			// 대상 게시글 내용
//			Map<String, Object> map = new HashMap<>();
//			map.put("target", report.getTargetTable());
//			if(report.getContent_type().contains("reply")) {
//				map.put("field_name", "replyNum");
//			} else {
//				map.put("field_name", "num");
//			}
//			map.put("content_type", report.getContent_type());
//			map.put("num", report.getTargetNum());
//			
//			Reports posts = service.findByPostsId(map);
//			if(posts != null) {
//				posts.setTargetContent(posts.getTargetContent().replaceAll("\n", "<br>"));
//				
//				if(report.getTargetTable().equals("photo") && posts.getImageFilename() != null) {
//					posts.setImageFilename("/uploads/photo/" + posts.getImageFilename());
//				}
//			}
//			
//			model.addAttribute("report", report);
//			model.addAttribute("posts", posts);
//			model.addAttribute("reportsCount", reportsCount);
//			
//			model.addAttribute("reportsStatus", status);
//			model.addAttribute("page", page);
//			model.addAttribute("schType", schType);
//			model.addAttribute("kwd", kwd);
//
//			model.addAttribute("query", query);
//
//			return "admin/reportsManage/article";
//			
//		} catch (NullPointerException e) {
//			log.info("article : ", e);
//		} catch (Exception e) {
//			log.info("article : ", e);
//		}
//		
//		return "redirect:/admin/reportsManage/main";
//	}
//	
//	@PostMapping("update")
//	public String updateReports(
//			Reports dto,
//			@RequestParam(name = "report_action") String report_action,
//			@RequestParam(name = "status", defaultValue = "0") int status,			
//			@RequestParam(name = "page") String page,
//			@RequestParam(name = "schType", defaultValue = "all") String schType,
//			@RequestParam(name = "kwd", defaultValue = "") String kwd,
//			HttpSession session,
//			Model model) throws Exception {
//
//		String query = "page=" + page;
//		try {
//			SessionInfo info = (SessionInfo)session.getAttribute("member");
//			
//			kwd = myUtil.decodeUrl(kwd);
//
//			if(status != 0) {
//				query += "&status=" + status;
//			}
//			if (! kwd.isBlank()) {
//				query += "&schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
//			}
//
//			// 신고 처리
//			dto.setHandledBy(info.getMemberId());
//			service.updateReports(dto);
//			
//			// 게시글 블록 또는 삭제
//			Map<String, Object> map = new HashMap<>();
//			map.put("target", dto.getTargetTable());
//			map.put("field_name", dto.getContent_type().contains("reply") ? "replyNum" : "num");
//			map.put("num", dto.getTargetNum());
//			map.put("content_type", dto.getContent_type());
//			
//			if(report_action.equals("blind")) {
//				map.put("block", 1);
//				service.updateBlockPosts(map);
//			} else if(report_action.equals("unlock")) {
//				map.put("block", 0);
//				service.updateBlockPosts(map);
//			} else if(report_action.equals("delete")) {
//				service.deletePosts(map);
//			}
//
//			return "redirect:/admin/report/article/" + dto.getNum() + "?" +query;
//			
//		} catch (NullPointerException e) {
//			log.info("article : ", e);
//		} catch (Exception e) {
//			log.info("article : ", e);
//		}
//		
//		return "redirect:/admin/report/main";
//	}	
//}
