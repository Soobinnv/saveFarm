package com.sp.app.farm.controller;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.common.MyUtil;
import com.sp.app.common.PaginateUtil;
import com.sp.app.farm.model.MyFarmSale;
import com.sp.app.farm.model.SessionInfo;
import com.sp.app.farm.model.Supply;
import com.sp.app.farm.model.Variety;
import com.sp.app.farm.service.SaleServiceImpl;
import com.sp.app.farm.service.SupplyServiceImpl;
import com.sp.app.farm.service.VarietyServiceImpl;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/farm/sales/*")
public class FarmSalesController {

	private final SupplyServiceImpl SupplyService;
	private final VarietyServiceImpl varietyService;
	private final PaginateUtil paginateUtil;
	private final MyUtil myUtil;
	private final SaleServiceImpl SaleService;
	
	@GetMapping("totalList")
	public String totalList(){
		
		try {
			
		} catch (Exception e) {
			log.info("totalList : ", e);
		}
	
		return "farm/sale/totalList";
	}
	
	@GetMapping("starList")
	public String starList(){
		
		try {
			
		} catch (Exception e) {
			log.info("starList : ", e);
		}
	
		return "farm/sale/starList";
	}

	@GetMapping("myFarmList")
	public String myFarmList(
	        @RequestParam(name = "page", defaultValue = "1") int current_page,
	        @RequestParam(name = "schType", defaultValue = "varietyName") String schType,
	        @RequestParam(name = "kwd", defaultValue = "") String kwd,
	        @RequestParam(name = "state", required = false) Integer state,
	        @RequestParam(name = "varietyNum", defaultValue = "-1") long varietyNum,
	        Model model,
	        HttpServletRequest req,
	        HttpSession session) {

	    try {
	        // 1) 세션 가드
	        SessionInfo info = (SessionInfo) session.getAttribute("farm");
	        if (info == null) {
	            return "redirect:/member/login";
	        }
	        final long farmNum = info.getFarmNum();

	        // 2) 파라미터 정리
	        final int size = 10; // 행(테이블) 페이지 크기
	        kwd = myUtil.decodeUrl(kwd == null ? "" : kwd.trim());
	        schType = (schType == null || schType.isBlank()) ? "varietyName" : schType;

	        // -------------------------
	        // A. Supply(행 단위) 페이징
	        // -------------------------
	        Map<String, Object> map = new HashMap<>();
	        map.put("farmNum", farmNum);
	        map.put("schType", schType);
	        map.put("kwd", kwd);
	        if (state != null) map.put("state", state);
	        if (varietyNum > 0) map.put("varietyNum", varietyNum);
	        map.put("productNumOnly", 1); // 승인건만(서비스/매퍼 해석)

	        int dataCount = SupplyService.listSupplyCount(map);
	        int total_page = (dataCount + (size - 1)) / size;
	        if (total_page == 0) total_page = 1;

	        int page = Math.max(1, Math.min(current_page, total_page));
	        int offset = (page - 1) * size;
	        if (offset < 0) offset = 0;
	        map.put("offset", offset);
	        map.put("size", size);

	        List<Supply> supplyList = SupplyService.listSupply(map);

	        // -------------------------
	        // B. 품목별 집계(saleList) 페이징 (별도 카운트 사용)
	        // -------------------------
	        Map<String, Object> saleMap = new HashMap<>();
	        saleMap.put("farmNum", farmNum);
	        saleMap.put("schType", schType);
	        saleMap.put("kwd", kwd);
	        if (state != null) saleMap.put("state", state);
	        if (varietyNum > 0) saleMap.put("varietyNum", varietyNum);
	        saleMap.put("productNumOnly", 1); 

	        // 집계 전용 카운트
	        int saleCount = SaleService.myFarmListByVarietyCount(saleMap);

	        final int salePageSize = 10; // 카드도 10개씩
	        int sale_total_page = (saleCount + (salePageSize - 1)) / salePageSize;
	        if (sale_total_page == 0) sale_total_page = 1;

	        // 같은 page 파라미터를 쓰되, 집계 기준으로 보정
	        int sale_page = Math.max(1, Math.min(current_page, sale_total_page));
	        int sale_offset = (sale_page - 1) * salePageSize;

	        saleMap.put("offset", sale_offset);
	        saleMap.put("size", salePageSize);

	        List<MyFarmSale> saleList = SaleService.myFarmListByVariety(saleMap);

	        // 상단 요약(현재 페이지의 카드 합계; 전체 합계가 필요하면 별도 쿼리 사용)
	        BigDecimal totalQty = BigDecimal.ZERO;
	        BigDecimal totalVarietyEarning = BigDecimal.ZERO;
	        for (MyFarmSale dto : saleList) {
	            if (dto.getTotalQty() != null) totalQty = totalQty.add(dto.getTotalQty());
	            if (dto.getTotalVarietyEarning() != null) totalVarietyEarning = totalVarietyEarning.add(dto.getTotalVarietyEarning());
	        }

	        // 전체 누적 매출(납품완료+승인 기준)
	        BigDecimal totalEarning = SaleService.myFarmTotalEarning(farmNum);
	        if (totalEarning == null) totalEarning = BigDecimal.ZERO;

	        // 7) 페이징 URL (행 테이블 기준)
	        String cp = req.getContextPath();
	        String baseUrl = cp + "/farm/sales/myFarmList";
	        List<String> parts = new ArrayList<>();
	        parts.add("size=" + size);
	        parts.add("schType=" + myUtil.encodeUrl(schType));
	        parts.add("kwd=" + myUtil.encodeUrl(kwd));
	        if (state != null)  parts.add("state=" + state);
	        if (varietyNum > 0) parts.add("varietyNum=" + varietyNum);
	        String listUrl = baseUrl + "?" + String.join("&", parts);
	        String paging = paginateUtil.paging(page, total_page, listUrl);

	        // 품목 셀렉터
	        Map<String,Object> varietyMap = new HashMap<>();
	        varietyMap.put("farmNum", farmNum);
	        varietyMap.put("productNumOnly", 1);
	        List<Variety> varietyList = SupplyService.listFarmVarieties(varietyMap);

	        // 8) 모델
	        model.addAttribute("supplyList", supplyList);      // 테이블(행)
	        model.addAttribute("saleList", saleList);          // 카드(집계)

	        // 요약/누적
	        model.addAttribute("totalQty", totalQty);
	        model.addAttribute("totalVarietyEarning", totalVarietyEarning);
	        model.addAttribute("totalEarning", totalEarning);

	        // 테이블(행) 페이징
	        model.addAttribute("dataCount", dataCount);
	        model.addAttribute("size", size);
	        model.addAttribute("page", page);
	        model.addAttribute("total_page", total_page);
	        model.addAttribute("paging", paging);

	        // 카드(집계) 페이징 값도 내려두면 JSP에서 쓸 수 있음(선택)
	        model.addAttribute("saleCount", saleCount);
	        model.addAttribute("sale_page", sale_page);
	        model.addAttribute("sale_total_page", sale_total_page);

	        // 공통 파라미터
	        model.addAttribute("schType", schType);
	        model.addAttribute("kwd", kwd);
	        model.addAttribute("state", state);
	        model.addAttribute("varietyNum", varietyNum);
	        model.addAttribute("varietyList", varietyList);

	    } catch (Exception e) {
	        log.error("myFarmList :", e);
	    }
	    return "farm/sales/myFarmList";
	}

	
	/*
	@GetMapping("myFarmList")
	public String myFarmList(
	        @RequestParam(name = "page", defaultValue = "1") int current_page,
	        @RequestParam(name = "schType", defaultValue = "varietyName") String schType,
	        @RequestParam(name = "kwd", defaultValue = "") String kwd,
	        @RequestParam(name = "state", required = false) Integer state,
	        @RequestParam(name = "varietyNum", defaultValue = "-1") long varietyNum,
	        Model model,
	        HttpServletRequest req,
	        HttpSession session) {

	    try {
	        // 1) 세션 가드
	        SessionInfo info = (SessionInfo) session.getAttribute("farm");
	        if (info == null) {
	            return "redirect:/member/login";
	        }
	        final long farmNum = info.getFarmNum();

	        // 2) 파라미터 정리
	        final int size = 10;
	        kwd = myUtil.decodeUrl(kwd == null ? "" : kwd.trim());
	        schType = (schType == null || schType.isBlank()) ? "varietyName" : schType;

	        // 3) 공통 필터 맵
	        Map<String, Object> map = new HashMap<>();
	        map.put("farmNum", farmNum);
	        map.put("schType", schType);
	        map.put("kwd", kwd);
	        if (state != null) map.put("state", state);
	        if (varietyNum > 0) map.put("varietyNum", varietyNum);
	        map.put("productNumOnly", 1); // 승인건만

	        // 4) Supply 기준 카운트/페이징
	        int dataCount = SupplyService.listSupplyCount(map);
	        int total_page = (dataCount + (size - 1)) / size;
	        if (total_page == 0) total_page = 1;
	        if (current_page < 1) current_page = 1;
	        if (current_page > total_page) current_page = total_page;

	        int offset = (current_page - 1) * size;
	        if (offset < 0) offset = 0;
	        map.put("offset", offset);
	        map.put("size", size);

	        // 5) 행단위 목록(Supply)
	        List<Supply> supplyList = SupplyService.listSupply(map);

	        // 6) 상단 합계는 MyFarmSale 집계로
	        //    (같은 필터맵 재사용: approvedOnly, varietyNum, kwd 등 동일하게 적용)

	        List<MyFarmSale> saleList = SaleService.myFarmListByVariety(map); 

	        BigDecimal totalQty = BigDecimal.ZERO;
	        BigDecimal totalVarietyEarning = BigDecimal.ZERO;
	        for (MyFarmSale dto : saleList) {
	            if (dto.getTotalQty() != null)
	                totalQty = totalQty.add(dto.getTotalQty());
	            if (dto.getTotalVarietyEarning() != null)
	                totalVarietyEarning = totalVarietyEarning.add(dto.getTotalVarietyEarning());
	        }

	        // (선택) 전체 누적 매출액(승인건 기준) — 기존 집계 쿼리 재사용
	        BigDecimal totalEarning = SaleService.myFarmTotalEarning(farmNum);
	        if (totalEarning == null) totalEarning = BigDecimal.ZERO;

	        // 7) 페이징 URL
	        String cp = req.getContextPath();
	        String baseUrl = cp + "/farm/sales/myFarmList";

	        List<String> parts = new ArrayList<>();
	        parts.add("size=" + size);
	        parts.add("schType=" + myUtil.encodeUrl(schType));
	        parts.add("kwd=" + myUtil.encodeUrl(kwd));
	        if (state != null)  parts.add("state=" + state);
	        if (varietyNum > 0) parts.add("varietyNum=" + varietyNum);

	        String listUrl = baseUrl + "?" + String.join("&", parts);
	        String paging = paginateUtil.paging(current_page, total_page, listUrl);

	        Map<String,Object> varietyMap = new HashMap<>();
	        varietyMap.put("farmNum", farmNum);
	        varietyMap.put("productNumOnly", 1); // 승인건만 보여주고 싶을 때

	        List<Variety> varietyList = SupplyService.listFarmVarieties(varietyMap);
	        model.addAttribute("varietyList", varietyList);
	        
	        // 8) 모델
	        model.addAttribute("supplyList", supplyList);              // 테이블은 Supply
	        model.addAttribute("saleList", saleList);            // (필요하면 화면에 추가 섹션으로)
	        model.addAttribute("totalQty", totalQty);            // 상단 요약(집계 합계)
	        model.addAttribute("totalVarietyEarning", totalVarietyEarning);
	        model.addAttribute("totalEarning", totalEarning);    // 전체 누적

	        model.addAttribute("dataCount", dataCount);
	        model.addAttribute("size", size);
	        model.addAttribute("page", current_page);
	        model.addAttribute("total_page", total_page);
	        model.addAttribute("paging", paging);

	        model.addAttribute("schType", schType);
	        model.addAttribute("kwd", kwd);
	        model.addAttribute("state", state);
	        model.addAttribute("varietyNum", varietyNum);

	    } catch (Exception e) {
	        log.error("myFarmList :", e);
	    }
	    return "farm/sales/myFarmList";
	}
*/
	
}
