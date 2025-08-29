package com.sp.app.farm.controller;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
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
import com.sp.app.farm.model.MonthlyVarietyStats;
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
@RequestMapping({"/farm/sales", "/farm/sales/*"})
public class FarmSalesController {

	private final SupplyServiceImpl supplyService;
	private final VarietyServiceImpl varietyService;
	private final PaginateUtil paginateUtil;
	private final MyUtil myUtil;
	private final SaleServiceImpl saleService;
	
	@GetMapping("totalList")
	public String totalList(
			@RequestParam(value = "varietyNum",  required = false) Long varietyNum,
	        @RequestParam(value = "varietyName", required = false) String varietyName,
	        Model model) {
	    try {
	    	// 1. 상단 TOP10 차트
	        Map<String, Object> topParam = new HashMap<>();
	        String endYmAll = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMM"));
	        topParam.put("startYm", "190001");  // 시작부터
	        topParam.put("endYm",   endYmAll);  // 현재달까지
	        topParam.put("topN",    10);        // 월별 Top10

	        List<MonthlyVarietyStats> monthlyVarietyList = saleService.listMonthlyVarietyWeight(topParam);
	        model.addAttribute("monthlyVarietyList", monthlyVarietyList);

	        // 2. 하단 라인차트: 선택 품목의 "최근 3년(36개월)", 현재달 포함
	        LocalDate nowMonth = LocalDate.now().withDayOfMonth(1); // 이번달 1일
	        final int monthsCount = 36;                         // 36개월
	        LocalDate start = nowMonth.minusMonths(monthsCount - 1); // 35개월 전(포함)

	        DateTimeFormatter ym     = DateTimeFormatter.ofPattern("yyyyMM");
	        DateTimeFormatter ymDash = DateTimeFormatter.ofPattern("yyyy-MM");

	        // === 기본 품목 결정 (요청 파라미터 없을 때) ===
	        // 드롭다운 목록을 먼저 받아서 기본 품목 고름 (샤인머스캣 우선, 없으면 첫 번째)
	        List<Variety> varietyList = varietyService.listAll();
	        if ((varietyNum == null) && (varietyName == null || varietyName.isBlank())) {
	            Variety def = varietyList.stream()
	                    .filter(v -> v.getVarietyName() != null && v.getVarietyName().contains("샤인머스캣"))
	                    .findFirst()
	                    .orElse(varietyList.isEmpty() ? null : varietyList.get(0));
	            if (def != null) {
	                varietyNum  = def.getVarietyNum();
	                varietyName = def.getVarietyName();
	            }
	        }
	        
	        // 3. 쿼리 파라미터 구성 (기본값이 정해진 상태)
	        Map<String, Object> p = new HashMap<>();
	        p.put("startYm", start.format(ym));
	        p.put("endYm",   nowMonth.format(ym));
	        if (varietyNum != null) p.put("varietyNum", varietyNum);
	        if (varietyName != null && !varietyName.isBlank()) p.put("varietyName", varietyName);

	        // 4. 시리즈 데이터 조회
	        // 결과: monthKey(YYYY-MM), varietyName, totalWeightG
	        List<MonthlyVarietyStats> seriesRows = saleService.listMonthlyVarietyWeight(p);
	        model.addAttribute("seriesRows", seriesRows);

	        // 5. x축 36개월 라벨
	        // x축용 36개월 라벨 (YYYY-MM)
	        List<String> months = new ArrayList<>(monthsCount);
	        for (int i = 0; i < monthsCount; i++) {
	            months.add(start.plusMonths(i).format(ymDash));
	        }
	        model.addAttribute("months", months);

	        // 6. 드롭다운/선택값 모델
	        model.addAttribute("varietyList", varietyList);
	        model.addAttribute("varietyNum", varietyNum);
	        model.addAttribute("varietyName", varietyName);

	    } catch (Exception e) {
	        log.error("totalList error:", e);
	    }
	    return "farm/sales/totalList";
	}
	
	
	@GetMapping("incomeList")
	public String incomeList(
			@RequestParam(value = "varietyNum",  required = false) Long varietyNum,
	        @RequestParam(value = "varietyName", required = false) String varietyName,
	        Model model) {
	    try {
	    	// 1. 상단 TOP10 차트
	        Map<String, Object> topParam = new HashMap<>();
	        String endYmAll = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMM"));
	        topParam.put("startYm", "190001");  // 시작부터
	        topParam.put("endYm",   endYmAll);  // 현재달까지
	        topParam.put("topN",    10);        // 월별 Top10

	        List<MonthlyVarietyStats> monthlyVarietyList = saleService.listMonthlyVarietyAmount(topParam);
	        model.addAttribute("monthlyVarietyList", monthlyVarietyList);

	        // 2. 하단 라인차트: 선택 품목의 "최근 3년(36개월)", 현재달 포함
	        LocalDate nowMonth = LocalDate.now().withDayOfMonth(1); // 이번달 1일
	        final int monthsCount = 36;                         // 36개월
	        LocalDate start = nowMonth.minusMonths(monthsCount - 1); // 35개월 전(포함)

	        DateTimeFormatter ym     = DateTimeFormatter.ofPattern("yyyyMM");
	        DateTimeFormatter ymDash = DateTimeFormatter.ofPattern("yyyy-MM");

	        // === 기본 품목 결정 (요청 파라미터 없을 때) ===
	        // 드롭다운 목록을 먼저 받아서 기본 품목 고름 (샤인머스캣 우선, 없으면 첫 번째)
	        List<Variety> varietyList = varietyService.listAll();
	        if ((varietyNum == null) && (varietyName == null || varietyName.isBlank())) {
	            Variety def = varietyList.stream()
	                    .filter(v -> v.getVarietyName() != null && v.getVarietyName().contains("샤인머스캣"))
	                    .findFirst()
	                    .orElse(varietyList.isEmpty() ? null : varietyList.get(0));
	            if (def != null) {
	                varietyNum  = def.getVarietyNum();
	                varietyName = def.getVarietyName();
	            }
	        }
	        
	        // 3. 쿼리 파라미터 구성 (기본값이 정해진 상태)
	        Map<String, Object> p = new HashMap<>();
	        p.put("startYm", start.format(ym));
	        p.put("endYm",   nowMonth.format(ym));
	        if (varietyNum != null) p.put("varietyNum", varietyNum);
	        if (varietyName != null && !varietyName.isBlank()) p.put("varietyName", varietyName);

	        // 4. 시리즈 데이터 조회 (36개월 라인)
	        List<MonthlyVarietyStats> seriesRows = saleService.listMonthlyVarietyAmount(p);
	        model.addAttribute("seriesRows", seriesRows);

	        // 5. x축 36개월 라벨
	        // x축용 36개월 라벨 (YYYY-MM)
	        List<String> months = new ArrayList<>(monthsCount);
	        for (int i = 0; i < monthsCount; i++) {
	            months.add(start.plusMonths(i).format(ymDash));
	        }
	        model.addAttribute("months", months);

	        // 6. 드롭다운/선택값 모델
	        model.addAttribute("varietyList", varietyList);
	        model.addAttribute("varietyNum", varietyNum);
	        model.addAttribute("varietyName", varietyName);
			
		} catch (Exception e) {
			log.info("incomeList : ", e);
		}
	
		return "farm/sales/incomeList";
	}
	
	@GetMapping("starList")
	public String starList(
			@RequestParam(value = "varietyNum",  required = false) Long varietyNum,
	        @RequestParam(value = "varietyName", required = false) String varietyName,
	        Model model) {
	    try {
	    	// 1. 상단 TOP10 차트
	        Map<String, Object> topParam = new HashMap<>();
	        String endYmAll = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMM"));
	        topParam.put("startYm", "190001");  // 시작부터
	        topParam.put("endYm",   endYmAll);  // 현재달까지
	        topParam.put("topN",    10);        // 월별 Top10

	        topParam.put("minReviewsPerMonth", 3);
	        
	        List<MonthlyVarietyStats> monthlyVarietyList = saleService.listMonthlyAvgStarByVariety(topParam);
	        model.addAttribute("monthlyVarietyList", monthlyVarietyList);

	        // 2. 하단 라인차트: 선택 품목의 "최근 3년(36개월)", 현재달 포함
	        LocalDate nowMonth = LocalDate.now().withDayOfMonth(1); // 이번달 1일
	        final int monthsCount = 36;                         // 36개월
	        LocalDate start = nowMonth.minusMonths(monthsCount - 1); // 35개월 전(포함)

	        DateTimeFormatter ym     = DateTimeFormatter.ofPattern("yyyyMM");
	        DateTimeFormatter ymDash = DateTimeFormatter.ofPattern("yyyy-MM");

	        // === 기본 품목 결정 (요청 파라미터 없을 때) ===
	        // 드롭다운 목록을 먼저 받아서 기본 품목 고름 (샤인머스캣 우선, 없으면 첫 번째)
	        List<Variety> varietyList = varietyService.listAll();
	        if ((varietyNum == null) && (varietyName == null || varietyName.isBlank())) {
	            Variety def = varietyList.stream()
	                    .filter(v -> v.getVarietyName() != null && v.getVarietyName().contains("샤인머스캣"))
	                    .findFirst()
	                    .orElse(varietyList.isEmpty() ? null : varietyList.get(0));
	            if (def != null) {
	                varietyNum  = def.getVarietyNum();
	                varietyName = def.getVarietyName();
	            }
	        }
	        
	        // 3. 쿼리 파라미터 구성 (기본값이 정해진 상태)
	        Map<String, Object> p = new HashMap<>();
	        p.put("startYm", start.format(ym));
	        p.put("endYm",   nowMonth.format(ym));
	        if (varietyNum != null) p.put("varietyNum", varietyNum);
	        if (varietyName != null && !varietyName.isBlank()) p.put("varietyName", varietyName);

	        // 4. 시리즈 데이터 조회 (36개월 라인)
	        List<MonthlyVarietyStats> seriesRows = saleService.listMonthlyAvgStarByVariety(p);
	        model.addAttribute("seriesRows", seriesRows);

	        // 5. x축 36개월 라벨
	        // x축용 36개월 라벨 (YYYY-MM)
	        List<String> months = new ArrayList<>(monthsCount);
	        for (int i = 0; i < monthsCount; i++) {
	            months.add(start.plusMonths(i).format(ymDash));
	        }
	        model.addAttribute("months", months);

	        // 6. 드롭다운/선택값 모델
	        model.addAttribute("varietyList", varietyList);
	        model.addAttribute("varietyNum", varietyNum);
	        model.addAttribute("varietyName", varietyName);
			
		} catch (Exception e) {
			log.info("starList : ", e);
		}
	
		return "farm/sales/starList";
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
	            return "redirect:/farm/member/login";
	        }
	        
	        final long farmNum = info.getFarmNum();

	      
	        final int size = 10; // 행(테이블) 페이지 크기
	        
	        kwd = myUtil.decodeUrl(kwd == null ? "" : kwd.trim());
	        schType = (schType == null || schType.isBlank()) ? "varietyName" : schType;

	        // 1. Supply(행 단위) 페이징
	        Map<String, Object> map = new HashMap<>();
	        
	        map.put("farmNum", farmNum);
	        map.put("schType", schType);
	        map.put("kwd", kwd);
	        
	        if (state != null) map.put("state", state);
	        if (varietyNum > 0) map.put("varietyNum", varietyNum);
	        
	        map.put("productNumOnly", 1); // 승인건만(서비스/매퍼 해석)

	        int dataCount = supplyService.listSupplyCount(map);
	        int total_page = (dataCount + (size - 1)) / size;
	        if (total_page == 0) total_page = 1;

	        int page = Math.max(1, Math.min(current_page, total_page));
	        int offset = (page - 1) * size;
	        if (offset < 0) offset = 0;
	        map.put("offset", offset);
	        map.put("size", size);

	        List<Supply> supplyList = supplyService.listSupply(map);

	        // 2. 품목별 집계(saleList) 페이징 (별도 카운트 사용)
	        Map<String, Object> saleMap = new HashMap<>();
	        saleMap.put("farmNum", farmNum);
	        saleMap.put("schType", schType);
	        saleMap.put("kwd", kwd);
	        if (state != null) saleMap.put("state", state);
	        if (varietyNum > 0) saleMap.put("varietyNum", varietyNum);
	        saleMap.put("productNumOnly", 1); 

	        // 3. 집계 전용 카운트
	        int saleCount = saleService.myFarmListByVarietyCount(saleMap);

	        final int salePageSize = 10; // 카드도 10개씩
	        int sale_total_page = (saleCount + (salePageSize - 1)) / salePageSize;
	        if (sale_total_page == 0) sale_total_page = 1;

	        // 4. 같은 page 파라미터를 쓰되, 집계 기준으로 보정
	        int sale_page = Math.max(1, Math.min(current_page, sale_total_page));
	        int sale_offset = (sale_page - 1) * salePageSize;

	        saleMap.put("offset", sale_offset);
	        saleMap.put("size", salePageSize);

	        List<MyFarmSale> saleList = saleService.myFarmListByVariety(saleMap);

	        // 5. 상단 요약(현재 페이지의 카드 합계; 전체 합계가 필요하면 별도 쿼리 사용)
	        BigDecimal totalQty = BigDecimal.ZERO;
	        BigDecimal totalVarietyEarning = BigDecimal.ZERO;
	        
	        for (MyFarmSale dto : saleList) {
	            if (dto.getTotalQty() != null) totalQty = totalQty.add(dto.getTotalQty());
	            if (dto.getTotalVarietyEarning() != null) totalVarietyEarning = totalVarietyEarning.add(dto.getTotalVarietyEarning());
	        }

	        // 6. 전체 누적 매출(납품완료+승인 기준)
	        Map<String, Object> totalMap = new HashMap<>();
	        totalMap.put("farmNum", farmNum);
	        totalMap.put("productNumOnly", 1); // 리스트/카드와 동일 기준으로 합치려면 유지
	        BigDecimal totalEarning = saleService.myFarmTotalEarning(totalMap);
	        if (totalEarning == null) totalEarning = BigDecimal.ZERO;

	        // 7. 페이징 URL (행 테이블 기준)
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
	        List<Variety> varietyList = supplyService.listFarmVarieties(varietyMap);

	        // 8. 모델
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
	
}
