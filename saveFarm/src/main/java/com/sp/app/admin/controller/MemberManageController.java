package com.sp.app.admin.controller;

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.admin.model.MemberManage;
import com.sp.app.admin.service.MemberManageService;
import com.sp.app.common.MyUtil;
import com.sp.app.common.PaginateUtil;

import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/admin/member/*")
public class MemberManageController {
	private final MemberManageService service;
	private final PaginateUtil paginateUtil;
	private final MyUtil myUtil;
	
	@GetMapping("/")
	public String handleMember() {
		return "admin/member/main";
	}
	
	@GetMapping("list")
	public String listMember(@RequestParam(name = "page", defaultValue = "1") int currentPage,
			@RequestParam(name = "schType", defaultValue = "loginId") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			@RequestParam(name = "enabled", defaultValue = "") String enabled,
			Model model,
			HttpServletResponse resp) throws Exception {
		
		try {
			int size = 5;
			int dataCount = 0;
			int totalPage = 0;
			
			kwd = myUtil.decodeUrl(kwd);
			
			Map<String, Object> map = new HashMap<>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			map.put("enabled", enabled);
			
			dataCount = service.dataCount(map);
			
			if(dataCount != 0) {
				totalPage = paginateUtil.pageCount(dataCount, size);
			}
			currentPage = Math.min(currentPage, totalPage);
			
			int offset = (currentPage - 1) * size;
			if(offset<0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			List<MemberManage> list = service.listMember(map);
			
			String paging = paginateUtil.adminPaging(currentPage, totalPage, "listMember");
			
			
			model.addAttribute("list", list);
			model.addAttribute("page", currentPage);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("size", size);
			model.addAttribute("totalPage", totalPage);
			model.addAttribute("paging", paging);
			model.addAttribute("enabled", enabled);
			model.addAttribute("schType", schType);
			model.addAttribute("kwd", kwd);
			
		} catch (Exception e) {
			log.info("listMember : ", e);
		}
		
		return "admin/member/list";
	}
	
	@GetMapping("details")
	public String detaileMember(@RequestParam(name = "memberId") Long memberId, 
			@RequestParam(name = "page") String page,
			Model model,
			HttpServletResponse resp) throws Exception {
		
		try {
			MemberManage dto = Objects.requireNonNull(service.findById(memberId));
			MemberManage memberStatus = service.findByStatus(memberId);
			List<MemberManage> listStatus = service.listMemberStatus(memberId);
			model.addAttribute("dto", dto);
			model.addAttribute("memberStatus", memberStatus);
			model.addAttribute("listStatus", listStatus);
			model.addAttribute("page", page);
			
		} catch (NullPointerException e) {
			resp.sendError(410);
			throw e;
		} catch (Exception e) {
			resp.sendError(406);
			throw e;
		}

		return "admin/member/details";
	}
	
	@PostMapping("updateMember")
	public Map<String, ?> updateMember(@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> model = new HashMap<>();
		String state = "true";
		try {
			service.updateMember(map);
		
		} catch (Exception e) {
			state = "false";
		}
		
		model.put("state", state);
		return model;
	}
	
	@ResponseBody
	@PostMapping("updateMemberStatus")
	public Map<String, ?> updateMemberStatus(MemberManage dto) throws Exception {
		Map<String, Object> model = new HashMap<>();

		String state = "true";
		try {
			// 회원 활성/비활성 변경
			Map<String, Object> map = new HashMap<>();
			map.put("memberId", dto.getMemberId());
			if (dto.getStatusCode() == 0) {
				map.put("enabled", 1);
			} else {
				map.put("enabled", 0);
			}
			
			System.out.println(map);
			System.out.println(map);
			System.out.println(map);
			service.updateMemberEnabled(map);

			// 회원 상태 변경 사항 저장
			service.insertMemberStatus(dto);

			if (dto.getStatusCode() == 0) {
				// 회원 패스워드 실패횟수 초기화
				service.updateFailureCountReset(dto.getMemberId());
			}
		} catch (Exception e) {
			state = "false";
		}

		model.put("state", state);
		return model;
	}
	
	
	
	@PostMapping("deleteMember")
	public String deleteMember(@RequestParam(name = "memberId") Long memberId, 
			Model model,
			HttpServletResponse resp) throws Exception {
		
		try {
			service.deleteMember(memberId);
		
		} catch (NullPointerException e) {
			resp.sendError(410);
			throw e;
		} catch (Exception e) {
			resp.sendError(406);
			throw e;
		}
		
		return "redirect:/admin/member/";
	}
}
