package com.sp.app.farm.controller;

import java.util.ArrayList;
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
import com.sp.app.farm.model.SessionInfo;
import com.sp.app.farm.model.Supply;
import com.sp.app.farm.model.Variety;
import com.sp.app.farm.service.SupplyServiceImpl;
import com.sp.app.farm.service.VarietyServiceImpl;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/farm/register/*")
public class FarmRegisterController {

	private final SupplyServiceImpl service;
	private final VarietyServiceImpl varietyService;
	private final PaginateUtil paginateUtil;
	private final MyUtil myUtil;

	@GetMapping("main")
    public String registerMain(Model model) {
        return "farm/register/main"; // 원하는 뷰
	}
	
	@GetMapping("list")
	public String list(
		@RequestParam(name = "page", defaultValue = "1") int current_page,
		@RequestParam(name = "schType", defaultValue = "all") String schType,
		@RequestParam(name = "kwd", defaultValue = "") String kwd,
		@RequestParam(name = "harvestDate", defaultValue = "") String harvestDate,
	    @RequestParam(name="state", defaultValue="1") int state,
	    @RequestParam(name="rescuedApply", defaultValue="-1") int rescuedApply,
	    @RequestParam(name="productNum", defaultValue="-1") long productNum,
	    @RequestParam(name="varietyNum", defaultValue="-1") long varietyNum,
		Model model,
		HttpServletRequest req,
		HttpSession session) {
	try {
		SessionInfo info = (SessionInfo) session.getAttribute("farm");
		if (info == null) {
		    return "redirect:/farm/member/login"; // 페이지 요청 규칙
		}
		
		int size = 10;
		int total_page = 0;
		int dataCount = 0;

		/*
		if (req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			kwd = myUtil.decodeUrl(kwd);
		}
		*/
		kwd = myUtil.decodeUrl(kwd);

		// 전체 페이지 수
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("schType", schType);
		map.put("kwd", kwd);
		map.put("state", state);
		/*
	    map.put("rescuedApply", rescuedApply);
	    map.put("productNum", productNum);
	    */
	    map.put("varietyNum", varietyNum);
		
        map.put("farmNum", info.getFarmNum());
		
		dataCount = service.listSupplyCount(map);
		if (dataCount != 0) {
			total_page = dataCount / size + (dataCount % size > 0 ? 1 : 0);
		}
		
		// 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
		current_page = Math.min(current_page, total_page);

		// 리스트에 출력할 데이터를 가져오기
		int offset = (current_page - 1) * size;
		if(offset < 0) offset = 0;

		map.put("offset", offset);
		map.put("size", size);
		map.put("state", state);

		// 글 리스트
		List<Supply> list = service.listSupply(map);

		String cp = req.getContextPath();
		/*
		String query = "";
		String listUrl = cp + "/farm/register/list";
        String articleUrl = cp + "/farm/register/detail?page=" + current_page;
		if (! kwd.isBlank()) {
			query = "schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
			
			listUrl += "?" + query;
			articleUrl += "&" + query;
		}
		*/
		
		// 1) 필터 문자열 구성
		List<String> parts = new ArrayList<>();
		parts.add("state=" + state); // ← 꼭 포함
		if (!kwd.isBlank()) {
		    parts.add("schType=" + schType);
		    parts.add("kwd=" + myUtil.encodeUrl(kwd));
		}
		if (rescuedApply != -1) parts.add("rescuedApply=" + rescuedApply);
		if (productNum   != -1) parts.add("productNum="   + productNum);
		if (varietyNum   != -1) parts.add("varietyNum="   + varietyNum);

		String filter = String.join("&", parts);

		// 2) 페이징용 base URL (필터만 포함, page는 paginateUtil이 붙임)
		String listUrl = cp + "/farm/register/list" + (filter.isEmpty() ? "" : ("?" + filter));
		
		//3) 상세로 가는 base URL (PK만 전달)
		String articleUrl = cp + "/farm/register/detail";
		
		String paging = paginateUtil.paging(current_page, total_page, listUrl);	
		
		model.addAttribute("list", list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("size", size);
		model.addAttribute("total_page", total_page);
		model.addAttribute("page", current_page);
		
		model.addAttribute("paging", paging);
		model.addAttribute("articleUrl", articleUrl);
		
		model.addAttribute("schType", schType);
		model.addAttribute("kwd", kwd);
		model.addAttribute("state", state);
		model.addAttribute("rescuedApply", rescuedApply);
		model.addAttribute("harvestDate", harvestDate);
		
		} catch (Exception e) {
			log.info("list : ", e);
		}
	
		return "farm/register/list";
	}
	
	@GetMapping("write")
	public String writeForm(Model model) {
		List<Variety> varieties = varietyService.listAll();
		model.addAttribute("varieties", varieties);
		model.addAttribute("mode", "write");
		
		return "farm/register/write";
	}
	
	@PostMapping("write")
	public String writeSubmit(
			@RequestParam(name="rescuedApply", defaultValue = "0") int rescuedApply,
			Supply dto,
			HttpSession session) {
	    try {
			SessionInfo info = (SessionInfo) session.getAttribute("farm");
			dto.setRescuedApply(rescuedApply);
			dto.setFarmNum(info.getFarmNum());
			service.insertSupply(dto);
			
		} catch (Exception e) {
			log.info("writeSubmit : ", e);
		}
		
	    return "redirect:/farm/register/main";
	}

	
	// 세부 정보 조회
	@GetMapping("detail")
	public String detail(
			@RequestParam(name = "supplyNum") long supplyNum,
			@RequestParam(name="back", defaultValue="register") String back,
	        Model model,
	        HttpSession session) throws Exception {

		try {
	        SessionInfo info = (SessionInfo) session.getAttribute("farm");
	        if (info == null) return "redirect:/farm/member/login";

	        Supply dto = service.findBySupplyNum(supplyNum);
	        if (dto == null || dto.getFarmNum() != info.getFarmNum()) {
	            return "redirect:/farm/register/list";
	        }
	        
	        String varietyName = varietyService.findByVarietyNum(dto.getVarietyNum()).getVarietyName();

	        model.addAttribute("dto", dto);
	        model.addAttribute("varietyName", varietyName);
	        
	        // 리스트에서 돌아가는 리스트 주소위해
	        model.addAttribute("back", back);
	        return "farm/register/detail";
	    } catch (Exception e) {
	        log.info("detail :", e);
	        return "redirect:/farm/register/list";
	    }
	}
	
	@GetMapping("update")
	public String updateForm(
			@RequestParam(name = "supplyNum") long supplyNum,
			@RequestParam(name="back", defaultValue="register") String back,
			Model model,
			HttpSession session) throws Exception {
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("farm");
			
			Supply dto = Objects.requireNonNull(service.findBySupplyNum(supplyNum));
			
			if (info == null) {
		        return "redirect:/farm/member/login";
		    }
			if (dto.getFarmNum() != info.getFarmNum()) {
				return "redirect:/farm/register/list?";
			}
			
			String varietyName = varietyService.findByVarietyNum(dto.getVarietyNum()).getVarietyName();
			List<Variety> varieties = varietyService.listAll();
			
			model.addAttribute("dto", dto);
			model.addAttribute("mode", "update");
			
			model.addAttribute("varietyName", varietyName);
			model.addAttribute("varieties", varieties);
			
			// 리스트에서 돌아가는 리스트 주소위해
	        model.addAttribute("back", back);
	        
			return "farm/register/write";
			
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("updateForm : ", e);
		}
		
		return "redirect:/farm/register/list?";
	}

	@PostMapping("update")
	public String updateSubmit(
			@RequestParam(name="rescuedApply", defaultValue = "0") int rescuedApply,
			Supply dto,
			@RequestParam(name = "page") String page) throws Exception {
		try {
			dto.setRescuedApply(rescuedApply);
			service.updateSupply(dto);		
		} catch (Exception e) {
			log.info("updateSubmit : ", e);
		}

		return "redirect:/farm/register/list?page=" + page;
	}

	@PostMapping("delete")
	public String delete(@RequestParam(name = "supplyNum") long supplyNum,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			@RequestParam(name = "state", defaultValue = "0") int state,
			HttpSession session) throws Exception {
		
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("farm");
			Supply dto = Objects.requireNonNull(service.findBySupplyNum(supplyNum));
			
			if (dto.getFarmNum() != info.getFarmNum()) {
				return "redirect:/farm/register/list";
			}
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("supplyNum", supplyNum);
			map.put("state", state);
			
			service.deleteSupply(map);
			
		} catch (Exception e) {
			log.info("delete : ", e);
		}

		return "redirect:/farm/register/list";
	}
	
	/*
	@PostMapping("changeState")
	public String changeState(@RequestParam int farmNum, @RequestParam String state) {
	    service.changeFarmState(farmNum, state);
	}
	*/
	
}
