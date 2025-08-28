package com.sp.app.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.admin.model.DashboardManage;
import com.sp.app.admin.model.ReturnManage;
import com.sp.app.admin.service.DashboardManageService;
import com.sp.app.model.Refund;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/admin")
public class HomeManageController {
	private final DashboardManageService service;
	
	@GetMapping("")
	public String handleHome(Model model) {
		
		try {
			List<Refund> refundList = service.dashboardRefundList();
			List<ReturnManage> returnList = service.dashboardReturnList();
			
			model.addAttribute("refundList", refundList);
			model.addAttribute("returnList", returnList);
		} catch (Exception e) {
			log.info("handleHome 에러: ", e);
		}
		
		return "admin/main/home";
	}
	
	@ResponseBody
	@GetMapping("/chart")
    public Map<String, Object> getChartData() throws Exception {
        
		List<DashboardManage> list = service.dashboardChart();
		
        List<String> categories = new ArrayList<>();
        List<Long> dataValues = new ArrayList<>();
        
        
        for(DashboardManage item : list) {
        	int month = Integer.parseInt(item.getOrderDate());
        	
        	categories.add(month + "월");
        	dataValues.add(item.getPayment());
        	
        }
        
        Map<String, Object> chartData = new HashMap<>();
        chartData.put("categories", categories);
        chartData.put("data", dataValues);
        
        return chartData;
    }
	
}
