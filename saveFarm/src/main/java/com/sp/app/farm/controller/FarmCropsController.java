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
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/farm/crops/*")
public class FarmCropsController {

	private final SupplyServiceImpl service;
	private final VarietyServiceImpl varietyService;
	private final PaginateUtil paginateUtil;
	private final MyUtil myUtil;
	
	@GetMapping("list")
	public String listFrom(
	        @RequestParam(name = "page", defaultValue = "1") int current_page,
	        @RequestParam(name = "schType", defaultValue = "all") String schType,
	        @RequestParam(name = "kwd", defaultValue = "") String kwd,
	        @RequestParam(name = "harvestDate", defaultValue = "") String harvestDate,
	        @RequestParam(name = "state", defaultValue = "0") int state,
	        @RequestParam(name = "rescuedApply", defaultValue = "-1") int rescuedApply,
	        @RequestParam(name = "productNum", defaultValue = "-1") long productNum,
	        @RequestParam(name = "varietyNum", defaultValue = "-1") long varietyNum,
	        Model model,
	        HttpServletRequest req,
	        HttpSession session) {

	    try {
	        SessionInfo info = (SessionInfo) session.getAttribute("farm");
	        if (info == null) {
	            return "redirect:/farm/member/login";
	        }

	        final int size = 10;

	        kwd = myUtil.decodeUrl(kwd == null ? "" : kwd.trim());

	        // --- 공통 파라미터 맵 구성 ---
	        Map<String, Object> map = new HashMap<>();
	        map.put("farmNum", info.getFarmNum());
	        map.put("schType", schType);
	        map.put("kwd", kwd);
	        map.put("state", state);               // state=0 포함(WhereList에서 -1만 전체)
	        map.put("rescuedApply", rescuedApply);
	        map.put("productNum", productNum);
	        map.put("varietyNum", varietyNum);

	        // harvestDate 단일 값을 날짜범위로 매핑(WhereList: fromDate/toDate 사용)
	        if (harvestDate != null && !harvestDate.isBlank()) {
	            map.put("fromDate", harvestDate);
	            map.put("toDate",   harvestDate);
	        }

	        // --- ★ LEFT JOIN 버전 카운트/리스트 호출 (다른 화면 영향 X) ---
	        int dataCount = service.farmSupplyListCount(map); // LEFT JOIN
	        int total_page = (dataCount + size - 1) / size;

	        // 페이지 보정: 최소 1
	        if (total_page == 0) {
	            current_page = 1;
	        } else {
	            current_page = Math.min(Math.max(current_page, 1), total_page);
	        }

	        int offset = (current_page - 1) * size;
	        map.put("offset", offset);
	        map.put("size",   size);

	        List<Supply> list = service.listByFarm(map);      // LEFT JOIN

	        // --- 페이징 URL 구성(필터 유지) ---
	        String cp = req.getContextPath();
	        List<String> parts = new ArrayList<>();
	        parts.add("state=" + state);
	        if (!kwd.isBlank()) {
	            parts.add("schType=" + schType);
	            parts.add("kwd=" + myUtil.encodeUrl(kwd));
	        }
	        if (rescuedApply != -1) parts.add("rescuedApply=" + rescuedApply);
	        if (productNum   != -1) parts.add("productNum="   + productNum);
	        if (varietyNum   != -1) parts.add("varietyNum="   + varietyNum);
	        if (!harvestDate.isBlank()) parts.add("harvestDate=" + harvestDate);

	        String filter   = String.join("&", parts);
	        String listUrl  = cp + "/farm/crops/list" + (filter.isEmpty() ? "" : ("?" + filter));
	        String paging   = paginateUtil.paging(current_page, total_page, listUrl);
	        String articleUrl = cp + "/farm/crops/detail";

	        // --- 모델 바인딩 ---
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
	        model.addAttribute("productNum", productNum);
	        model.addAttribute("varietyNum", varietyNum);

	    } catch (Exception e) {
	        log.error("list error", e);
	    }

	    return "farm/crops/list";
	}
	
	@PostMapping("list")
	public String listsubmit(
	        // ★ 폼에서 보내는 이름과 일치시킴: targetState
	        @RequestParam(name = "targetState", required = false) Integer targetState,
	        @RequestParam(name = "supplyNums",    required = false) List<Long> supplyNums,

	        // 화면 유지용
	        @RequestParam(name = "page",      defaultValue = "1")  int current_page,
	        @RequestParam(name = "schType",   defaultValue = "all") String schType,
	        @RequestParam(name = "kwd",       defaultValue = "")    String kwd,
	        // 드롭다운으로 보고 있던 "현재 화면의 상태값" (필터)
	        @RequestParam(name = "state",     defaultValue = "0")   int viewState,
	        @RequestParam(name = "rescuedApply", defaultValue = "-1") int rescuedApply,
	        @RequestParam(name = "productNum",   defaultValue = "-1") long productNum,
	        @RequestParam(name = "varietyNum",   defaultValue = "-1") long varietyNum,
	        @RequestParam(name = "harvestDate",  defaultValue = "")  String harvestDate,

	        HttpSession session,
	        RedirectAttributes reAttr) {

	    SessionInfo info = (SessionInfo) session.getAttribute("farm");
	    if (info == null) return "redirect:/farm/member/login";

	    // 1) 일괄 상태변경: targetState + 체크된 항목이 있을 때만 실행
	    if (targetState != null && supplyNums != null && !supplyNums.isEmpty()) {
	        Map<String, Object> map = new HashMap<>();
	        map.put("farmNum", info.getFarmNum()); // 본인 농가 건만
	        map.put("state",   targetState);       // ★ mapper는 'state' 키로 받음
	        map.put("supplyNums", supplyNums);     // IN 절

	        int affected = service.updateState(map);

	        if (affected != supplyNums.size()) {
	            reAttr.addFlashAttribute("warn",
	                "요청 " + supplyNums.size() + "건 중 " + affected + "건만 변경되었습니다.");
	        } else {
	            reAttr.addFlashAttribute("msg", affected + "건 상태 변경 완료");
	        }
	    }

	    // 2) 보고 있던 필터/페이지 유지하여 목록으로 복귀
	    reAttr.addAttribute("state", viewState); // ★ 화면 필터용 state
	    if (kwd != null && !kwd.isBlank()) {
	        reAttr.addAttribute("schType", schType);
	        reAttr.addAttribute("kwd", kwd);
	    }
	    if (rescuedApply != -1) reAttr.addAttribute("rescuedApply", rescuedApply);
	    if (productNum   != -1) reAttr.addAttribute("productNum",   productNum);
	    if (varietyNum   != -1) reAttr.addAttribute("varietyNum",   varietyNum);
	    if (harvestDate  != null && !harvestDate.isBlank()) {
	        reAttr.addAttribute("harvestDate", harvestDate);
	    }
	    reAttr.addAttribute("page", current_page);

	    // ★ 오타 수정: clist → list
	    return "redirect:/farm/crops/list";
	}
	
	@GetMapping("write")
	public String writeForm(
			@RequestParam(name="modal", required=false, defaultValue="0") int modal,
			Model model, 
			HttpSession session) {
		SessionInfo info = (SessionInfo) session.getAttribute("farm");
        if (info == null) return "redirect:/farm/member/login";
		
		List<Variety> varieties = varietyService.listAll();
		model.addAttribute("varieties", varieties);
		model.addAttribute("mode", "write");
		
		if (modal == 1) return "farm/crops/write";
		
		return "farm/crops/write";
	}
	
	@PostMapping("write")
	public String writeSubmit(
			@RequestParam(name="rescuedApply", defaultValue = "0") int rescuedApply,
			Supply dto,
			HttpSession session) {
	    try {
			SessionInfo info = (SessionInfo) session.getAttribute("farm");
			if (info == null) return "redirect:/farm/member/login";
			dto.setRescuedApply(rescuedApply);
			dto.setFarmNum(info.getFarmNum());
			dto.setState(0);
			
			service.insertCrops(dto);
			
		} catch (Exception e) {
			log.info("writeSubmit : ", e);
		}
		
	    return "redirect:/farm/crops/list";
	}

	
	// 세부 정보 조회
	@GetMapping("detail")
	public String detail(
			@RequestParam(name = "supplyNum") long supplyNum,
			@RequestParam(name = "modal", defaultValue = "0") int modal,
			Model model,
			HttpSession session,
			HttpServletResponse resp) {
	    try {
	        SessionInfo info = (SessionInfo) session.getAttribute("farm");
	        if (info == null) {
	            // 모달 요청이면 상태코드만 내려서 fetch가 로그인 이동 처리하게 함
	            if (modal == 1) {
	                resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // 401
	                return null;
	            }
	            return "redirect:/farm/member/login";
	        }

	        Supply dto = service.findBySupplyNum(supplyNum);
	        if (dto == null || dto.getFarmNum() != info.getFarmNum()) {
	            if (modal == 1) {
	                resp.setStatus(HttpServletResponse.SC_FORBIDDEN); // 403
	                return null;
	            }
	            return "redirect:/farm/crops/list";
	        }

	        String varietyName = varietyService
	                .findByVarietyNum(dto.getVarietyNum())
	                .getVarietyName();

	        model.addAttribute("dto", dto);
	        model.addAttribute("varietyName", varietyName);

	        // modal=1 이면 부분 뷰(헤더/푸터/<!DOCTYPE> 없는 JSP)
	        return "farm/crops/detail";

	    } catch (Exception e) {
	        log.error("detail error: supplyNum={}, modal={}", supplyNum, modal, e);
	        if (modal == 1) {
	            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500
	            return null;
	        }
	        return "redirect:/farm/crops/list";
	    }
	}
	
	@GetMapping("update")
    public String updateForm(@RequestParam(name="supplyNum") long supplyNum,
                             Model model,
                             HttpSession session) {
        try {
            SessionInfo info = (SessionInfo) session.getAttribute("farm");
            if (info == null) return "redirect:/farm/member/login";

            Supply dto = Objects.requireNonNull(service.findBySupplyNum(supplyNum));
            if (dto.getFarmNum() != info.getFarmNum()) {
                return "redirect:/farm/crops/list";
            }

            List<Variety> varieties = varietyService.listAll();
            String varietyName = varietyService.findByVarietyNum(dto.getVarietyNum()).getVarietyName();

            model.addAttribute("dto", dto);
            model.addAttribute("mode", "update");
            model.addAttribute("varieties", varieties);
            model.addAttribute("varietyName", varietyName);

            return "farm/crops/write"; 
        } catch (Exception e) {
            log.error("updateForm: ", e);
        }
        return "redirect:/farm/crops/list";
    }


    @PostMapping("update")
    public String updateSubmit(@RequestParam(name="rescuedApply", defaultValue="0") int rescuedApply,
                               Supply dto,
                               @RequestParam(name="page", defaultValue="1") String page,
                               HttpSession session) {
        try {
            SessionInfo info = (SessionInfo) session.getAttribute("farm");
            if (info == null) return "redirect:/farm/member/login";

            dto.setRescuedApply(rescuedApply);
            service.updateSupply(dto);
        } catch (Exception e) {
            log.error("updateSubmit: ", e);
        }
        return "redirect:/farm/crops/list?page=" + page;
    }

    @PostMapping("delete")
    public String delete(@RequestParam(name="supplyNum") long supplyNum,
			             @RequestParam(name="page",    defaultValue="1")  int page,
                         @RequestParam(name="state", defaultValue="0") int state,
                         @RequestParam(name="schType", defaultValue="all") String schType,
                         @RequestParam(name="kwd", defaultValue="") String kwd,
                         Model model,
                         HttpSession session,
                         RedirectAttributes reAttr) {
        try {
            SessionInfo info = (SessionInfo) session.getAttribute("farm");
            if (info == null) return "redirect:/farm/member/login";

            Supply dto = Objects.requireNonNull(service.findBySupplyNum(supplyNum));
            if (dto.getFarmNum() != info.getFarmNum()) {
                return "redirect:/farm/crops/list";
            }

            String varietyName = varietyService.findByVarietyNum(dto.getVarietyNum()).getVarietyName();
            model.addAttribute("dto", dto);
            model.addAttribute("varietyName", varietyName);
            
            Map<String, Object> map = new HashMap<>();
            map.put("supplyNum", supplyNum);
            map.put("farmNum", info.getFarmNum());
            
            service.deleteSupply(map);

            reAttr.addFlashAttribute("msg", "삭제되었습니다.");
        } catch (Exception e) {
            log.error("delete: ", e);
            reAttr.addFlashAttribute("warn", "삭제 중 오류가 발생했습니다.");
        }

        // 필터 유지
        reAttr.addAttribute("state", state);
        if (kwd != null && !kwd.isBlank()) {
            reAttr.addAttribute("schType", schType);
            reAttr.addAttribute("kwd", kwd);
        }
        return "redirect:/farm/crops/list";
    }	
}
