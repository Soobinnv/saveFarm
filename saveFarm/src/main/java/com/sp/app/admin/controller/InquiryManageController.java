package com.sp.app.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.admin.model.InquiryManage;
import com.sp.app.admin.service.InquiryManageService;
import com.sp.app.common.MyUtil;
import com.sp.app.common.PaginateUtil;
import com.sp.app.model.SessionInfo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/admin/inquiry/*")
public class InquiryManageController {
	private final InquiryManageService service;
	private final PaginateUtil paginateUtil;
	private final MyUtil myUtil;
	
	@GetMapping("inquiryList/{itemId}")
	public String handleInquiryList(
			@PathVariable("itemId") int itemId,
			@RequestParam(name = "page", defaultValue = "1") int currentPage,
			@RequestParam(name = "schType", defaultValue = "inquiryNum") String schType,
			@RequestParam(name = "kwd",defaultValue = "") String kwd,
			Model model,
			HttpServletRequest req) throws Exception {
		
		try {
			int size = 5;
			int totalPage;
			int dataCount;
			
			kwd = myUtil.decodeUrl(kwd);

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("itemId", itemId);
			map.put("schType", schType);
			map.put("kwd", kwd);
			
			dataCount = service.inquiryCount(map);
			totalPage = paginateUtil.pageCount(dataCount, size);

			currentPage = Math.min(currentPage, totalPage);
			
			int offset = (currentPage - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);

			List<InquiryManage> list = service.listInquiry(map);
			
			String cp = req.getContextPath();
			String listUrl = cp + "/admin/inquiry/inquiryList/" + itemId;
			String articleUrl = cp + "/admin/inquiry/article/"+ itemId + "?page=" + currentPage;
			
			String query = "page=" + currentPage;
			String qs = "";
			if (kwd.length() != 0) {
				qs = "schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
				query += "&" + qs;
				listUrl += "?" + qs;
				articleUrl += "?" + qs;
			}
			
			String paging = paginateUtil.adminPagingUrl(currentPage, totalPage, listUrl);
			String title = "회원 문의";
			if(itemId == 200) {
				title = "농가 문의";
			} 
			
			model.addAttribute("title", title);
			model.addAttribute("itemId", itemId);
			model.addAttribute("articleUrl", articleUrl);
			
			model.addAttribute("list", list);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("query", query);
			
			model.addAttribute("schType", schType);
			model.addAttribute("kwd", kwd);
			
			model.addAttribute("page", currentPage);
			model.addAttribute("size", size);
			model.addAttribute("totalPage", totalPage);
			model.addAttribute("paging", paging);
			
		} catch (Exception e) {
			log.info("handleInquiryList : ", e);
		}
		
		return "admin/inquiry/inquiryList";
	}
	
	
	@GetMapping("article/{itemId}")
	public String article(
			@PathVariable("itemId") int itemId,
			@RequestParam(name = "inquiryNum") long inquiryNum,
			@RequestParam(name = "page") String page,
			@RequestParam(name = "schType", defaultValue = "inquiryNum") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			HttpSession session,
			Model model) throws Exception {

		String query = "page=" + page;
		try {
			kwd = myUtil.decodeUrl(kwd);
			if (! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
			}
			
			InquiryManage dto = Objects.requireNonNull(service.findById(inquiryNum));
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			if(dto.getAnswer() != null) {
				dto.setAnswer(dto.getAnswer().replaceAll("\n", "<br>"));
			}
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("itemId", itemId);
			map.put("schType", schType);
			map.put("kwd", kwd);
			map.put("inquiryNum", inquiryNum);
			
			InquiryManage prevDto = service.findByPrev(map);
			InquiryManage nextDto = service.findByNext(map);
			
			model.addAttribute("dto", dto);
			model.addAttribute("prevDto", prevDto);
			model.addAttribute("nextDto", nextDto);
			
			model.addAttribute("page", page);
			model.addAttribute("schType", schType);
			model.addAttribute("kwd", kwd);
			model.addAttribute("query", query);

			return "admin/inquiry/article";
			
		} catch (NullPointerException e) {
			log.info("article : ", e);
		} catch (Exception e) {
			log.info("article : ", e);
		}
		
		return "redirect:/admin/inquiry/inquiryList/" + itemId + "?" + query;
	}

	@PostMapping("answer/{itemId}")
	public String answerSubmit(InquiryManage dto,
			@PathVariable("itemId") int itemId,
			@RequestParam(name = "page") String page,
			@RequestParam(name = "schType", defaultValue = "inquiryNum") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			HttpSession session) throws Exception {

		String query = "page=" + page;
		try {
			if (! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
			}
			
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			dto.setAnswerId(info.getMemberId());
			service.updateAnswer(dto);
			
			System.out.println("값이 뭘까요 ? " +dto.getProcessResult());
		} catch (Exception e) {
			log.info("answerSubmit : ", e);
		}

		return "redirect:/admin/inquiry/inquiryList/"+ itemId +"?" + query;
	}


	@GetMapping("delete/{itemId}")
	public String delete(
			@PathVariable("itemId") int itemId,
			@RequestParam(name = "inquiryNum") long inquiryNum,
			@RequestParam(name = "page") String page,
			@RequestParam(name = "schType", defaultValue = "inquiryNum") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			@RequestParam(name = "mode") String mode,
			HttpSession session) throws Exception {

		String query = "page=" + page;
		try {
			kwd = myUtil.decodeUrl(kwd);
			if (! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
			}
			
			if(mode.equals("answer")) {
				service.deleteAnswer(inquiryNum);
			} else {
				service.deleteInquiry(inquiryNum);
			}

			
		} catch (Exception e) {
			log.info("delete : ", e);
		}
		
		return "redirect:/admin/inquiry/inquiryList/"+ itemId + "?" + query;
	}
	
	
}
