package com.sp.app.farm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.common.MyUtil;
import com.sp.app.common.PaginateUtil;
import com.sp.app.farm.model.Inquiry;
import com.sp.app.farm.model.SessionInfo;
import com.sp.app.farm.service.InquiryService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

// 인콰이어리(1:1 문의)
@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/farm/inquiry/*")
public class FarmInquiryController {
	private final InquiryService service;
	private final PaginateUtil paginateUtil;
	private final MyUtil myUtil;
	
	@GetMapping("list")
	public String list(@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			Model model,
			HttpServletRequest req,
			HttpSession session) throws Exception {
		
		try {
			int size = 10;
			int total_page = 0;
			int dataCount = 0;

			kwd = myUtil.decodeUrl(kwd);

			// 전체 페이지 수
			SessionInfo info = (SessionInfo) session.getAttribute("farm");
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			map.put("farmNum", info.getFarmNum());
			
			dataCount = service.dataCount(map);
			if (dataCount != 0) {
				total_page = paginateUtil.pageCount(dataCount, size);
			}

			current_page = Math.min(current_page, total_page);

			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;

			map.put("offset", offset);
			map.put("size", size);

			// 글 리스트
			List<Inquiry> list = service.listInquiry(map);

			String cp = req.getContextPath();
			String query = "";
			String listUrl = cp + "/farm/inquiry/list";
			String articleUrl = cp + "/farm/inquiry/article?page=" + current_page;
			if (! kwd.isBlank()) {
				query = "schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);

				listUrl += "?" + query;
				articleUrl += "&" + query;
			}

			String paging = paginateUtil.paging(current_page, total_page, listUrl);

			model.addAttribute("list", list);
			model.addAttribute("articleUrl", articleUrl);
			model.addAttribute("page", current_page);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("total_page", total_page);
			model.addAttribute("paging", paging);

			model.addAttribute("schType", schType);
			model.addAttribute("kwd", kwd);
			
		} catch (Exception e) {
			log.info("list : ", e);
		}

		return "farm/inquiry/list";
	}

	@GetMapping("write")
	public String writeForm(Model model) throws Exception {
		model.addAttribute("mode", "write");
		return "farm/inquiry/write";
	}

	@PostMapping("write")
	public String writeSubmit(Inquiry dto, HttpSession session) throws Exception {
		
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("farm");
			
			dto.setFarmNum(info.getFarmNum());
			service.insertInquiry(dto);
		} catch (Exception e) {
			log.info("writeSubmit : ", e);
		}

		return "redirect:/farm/inquiry/list";
	}

	@GetMapping("article")
	public String article(@RequestParam(name = "inquiryNum") long inquiryNum,
			@RequestParam(name = "page") String page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			Model model,
			HttpSession session) throws Exception {

		String query = "page=" + page;
		try {
			kwd = myUtil.decodeUrl(kwd);
			if (! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
			}
			
			SessionInfo info = (SessionInfo) session.getAttribute("farm");
			
			Inquiry dto = Objects.requireNonNull(service.findById(inquiryNum));
			if (dto.getFarmNum() != info.getFarmNum()) {
				return "redirect:/inquiry/list?" + query;
			}
			
			dto.setSubject(dto.getSubject().replaceAll("\n", "<br>"));
			if(dto.getAnswer() != null) {
				dto.setAnswer(dto.getAnswer().replaceAll("\n", "<br>"));
			}			

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("farmNum", info.getFarmNum());
			map.put("schType", schType);
			map.put("kwd", kwd);
			map.put("inquiryNum", inquiryNum);
			Inquiry prevDto = service.findByPrev(map);
			Inquiry nextDto = service.findByNext(map);			
			
			model.addAttribute("dto", dto);
			model.addAttribute("prevDto", prevDto);
			model.addAttribute("nextDto", nextDto);
			
			model.addAttribute("page", page);
			model.addAttribute("schType", schType);
			model.addAttribute("kwd", kwd);
			model.addAttribute("query", query);

			return "farm/inquiry/article";
			
		} catch (NullPointerException e) {
			log.info("article : ", e);
		} catch (Exception e) {
			log.info("article : ", e);
		}
		
		return "redirect:/farm/inquiry/list?" + query;

	}

	@GetMapping("delete")
	public String delete(@RequestParam(name = "inquiryNum") long inquiryNum,
			@RequestParam(name = "page") String page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			HttpSession session) throws Exception {
		
		String query = "page=" + page;
		try {
			kwd = myUtil.decodeUrl(kwd);
			if (! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
			}

			SessionInfo info = (SessionInfo) session.getAttribute("farm");
			
			Inquiry dto = Objects.requireNonNull(service.findById(inquiryNum));
			
			if (dto.getFarmNum() == info.getFarmNum()) {
				service.deleteInquiry(inquiryNum);
			}
		} catch (NullPointerException e) {
			log.info("delete : ", e);
		} catch (Exception e) {
			log.info("delete : ", e);
		}

		return "redirect:/farm/inquiry/list?" + query;
	}
}

