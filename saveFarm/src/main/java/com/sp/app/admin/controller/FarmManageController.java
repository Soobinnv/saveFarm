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
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.admin.model.CategoryInfo;
import com.sp.app.admin.model.FarmManage;
import com.sp.app.admin.model.NoticeManage;
import com.sp.app.admin.service.FarmManageService;
import com.sp.app.common.MyUtil;
import com.sp.app.common.PaginateUtil;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/admin/farm/*")
public class FarmManageController {
	private final FarmManageService service;
	private final PaginateUtil paginateUtil;
	private final MyUtil myUtil;
	
	
	@GetMapping("/")
	public String handleFarmMain(Model model) {
		
		return "admin/farm/main";
	}
	
	@GetMapping("farmList")
	public String listFarm(@RequestParam(name = "page", defaultValue = "1") int currentPage,
			@RequestParam(name = "schType", defaultValue = "FarmId") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
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
			
			dataCount = service.dataCount(map);
			
			if(dataCount != 0) {
				totalPage = paginateUtil.pageCount(dataCount, size);
			}
			currentPage = Math.min(currentPage, totalPage);
			
			int offset = (currentPage - 1) * size;
			if(offset<0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			List<FarmManage> list = service.listFarm(map);
			
			String paging = paginateUtil.adminPaging(currentPage, totalPage, "listFarm");
			
			
			model.addAttribute("list", list);
			model.addAttribute("page", currentPage);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("size", size);
			model.addAttribute("totalPage", totalPage);
			model.addAttribute("paging", paging);
			model.addAttribute("schType", schType);
			model.addAttribute("kwd", kwd);
			
		} catch (Exception e) {
			log.info("listFarm : ", e);
		}
		
		return "admin/farm/farmList";
	}
	
	@GetMapping("details")
	public String detaileFarm(@RequestParam(name = "farmNum") long farmNum, 
			@RequestParam(name = "page") String page,
			Model model,
			HttpServletResponse resp) throws Exception {
		
		try {
			FarmManage dto = Objects.requireNonNull(service.findById(farmNum));
			model.addAttribute("dto", dto);
			model.addAttribute("page", page);
			
		} catch (NullPointerException e) {
			resp.sendError(410);
			throw e;
		} catch (Exception e) {
			resp.sendError(406);
			throw e;
		}

		return "admin/farm/details";
	}
	
	@ResponseBody
	@PostMapping("updateFarm")
	public Map<String, ?> updateFarm(FarmManage dto) throws Exception {
		Map<String, Object> model = new HashMap<>();
		String state = "true";
		try {
			service.updateFarm(dto);
		
		} catch (Exception e) {
			state = "false";
		}
		
		model.put("state", state);
		return model;
	}
	
	@ResponseBody
	@PostMapping("updateFarmStatus")
	public Map<String, ?> updateMemberStatus(FarmManage dto) throws Exception {
		Map<String, Object> model = new HashMap<>();

		String state = "true";
		try {
			// 회원 활성/비활성 변경
			Map<String, Object> map = new HashMap<>();
			map.put("farmNum", dto.getFarmNum());
			map.put("status", dto.getStatus());
			
			
			service.updateFarmStatus(map);

//			if (dto.getStatus() == 3) {
//				// 회원 패스워드 실패횟수 초기화
//				service.updateFailureCountReset(dto.getFarmNum());
//			}
		} catch (Exception e) {
			state = "false";
		}

		model.put("state", state);
		return model;
	}
	
	@GetMapping("apply")
	public String handleFarmApply(Model model) {
		
		
		return "admin/farm/apply";
	}
	@GetMapping("applyFormUpdate")
	public String handleFarmApplyFormUpdate(Model model) {
		
		
		return "admin/farm/applyFormUpdate";
	}
}
