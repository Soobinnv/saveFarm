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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
@RequestMapping(value = "/farm/delivery/*")
public class FarmDeliveryController {

	private final SupplyServiceImpl service;
	private final VarietyServiceImpl varietyService;
	private final PaginateUtil paginateUtil;
	private final MyUtil myUtil;

	@GetMapping("main")
    public String deliveryMain(Model model) {
        return "farm/delivery/main"; // 원하는 뷰
	}
	
	@GetMapping("list")
	public String listFrom(
		@RequestParam(name = "page", defaultValue = "1") int current_page,
		@RequestParam(name = "schType", defaultValue = "all") String schType,
		@RequestParam(name = "kwd", defaultValue = "") String kwd,
		@RequestParam(name = "harvestDate", defaultValue = "") String harvestDate,
	    @RequestParam(name="state", defaultValue="2") int state,
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
		
		// 3) 상세로 가는 base URL (PK만 전달)
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
	
		return "farm/delivery/list";
	}
	
	@PostMapping("list")
	public String listsubmit(
	        @RequestParam(name = "targetState", defaultValue = "-1") int targetState,
	        @RequestParam(name = "supplyNums", required = false) List<Long> supplyNums,
	        @RequestParam(name = "page", defaultValue = "1") int current_page,
	        @RequestParam(name = "schType", defaultValue = "all") String schType,
	        @RequestParam(name = "kwd", defaultValue = "") String kwd,
	        @RequestParam(name = "state", defaultValue = "2") int viewState, // 현재 화면 드롭다운 상태
	        HttpSession session,
	        Model model,
	        final RedirectAttributes reAttr ) {
	    SessionInfo info = (SessionInfo) session.getAttribute("farm");
	    if (info == null) return "redirect:/farm/member/login";

	    // 1) 체크박스 선택 + 목표상태가 있을 때만 일괄 상태 변경
	    if (targetState != -1 && supplyNums != null && !supplyNums.isEmpty()) {
	        Map<String, Object> map = new HashMap<>();
	        map.put("farmNum", info.getFarmNum()); // 본인 농가 것만
	        map.put("state", targetState);
	        map.put("supplyNums", supplyNums);     // IN 절로 사용

	        int affected = service.updateState(map);

	        // 안내 메시지(선택사항: 필요 없으면 주석)
	        if (affected != supplyNums.size()) {
	            reAttr.addFlashAttribute("warn",
	                "요청 " + supplyNums.size() + "건 중 " + affected + "건만 변경되었습니다.");
	        } else {
	            reAttr.addFlashAttribute("msg", affected + "건 상태 변경 완료");
	        }

	        // 보고 있던 필터(상태/검색) 유지해서 목록으로
	        reAttr.addAttribute("state", viewState);
	        if (kwd != null && !kwd.isBlank()) {
	            reAttr.addAttribute("schType", schType);
	            reAttr.addAttribute("kwd", kwd);
	        }
	        reAttr.addAttribute("page", current_page);

	        return "redirect:/farm/delivery/list";
	    }

	    // 2) 배치 변경 조건이 아니면, 그냥 목록으로 되돌림(필터 유지)
	    reAttr.addAttribute("state", viewState);
	    if (kwd != null && !kwd.isBlank()) {
	        reAttr.addAttribute("schType", schType);
	        reAttr.addAttribute("kwd", kwd);
	    }
	    reAttr.addAttribute("page", current_page);

	    return "redirect:/farm/delivery/list";
	}
	
	@GetMapping("update")
	public String updateForm(
			@RequestParam(name = "supplyNum") long supplyNum,
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
