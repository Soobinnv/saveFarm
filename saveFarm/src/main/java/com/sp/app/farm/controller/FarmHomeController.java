package com.sp.app.farm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.sp.app.model.TotalCount;
import com.sp.app.service.TotalCountService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class FarmHomeController {
	
	private final TotalCountService totalCountService;
	
	@GetMapping("/farm")
	public String handleHome(Model model) {
		// 1) 총 판매중량, 총 판매금액
        TotalCount totals = totalCountService.getSiteTotalsAllTime();
        long totalWeightG = (totals != null) ? totals.getTotalWeightG() : 0L;
        long totalAmount  = (totals != null) ? totals.getTotalAmount()  : 0L;

        // 2) 농가회원 수
        TotalCount farmOnly = totalCountService.countFarm();
        int farmCount = (farmOnly != null) ? farmOnly.getFarmCount() : 0;

        // 3) JSP에서 바로 쓰기
        model.addAttribute("farmCount", farmCount);
        model.addAttribute("totalWeightG", totalWeightG);
        model.addAttribute("totalAmount", totalAmount);
        
		return "farm/main/farmHome";
	}
	
	@GetMapping("/farm/guide")
	public String guide (Model model) {
		
		return "farm/guide/guidePage";
	}
}
