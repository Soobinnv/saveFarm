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
import com.sp.app.controller.OrderController;
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
		Map<String, Object> chartData = new HashMap<>();
        try {
        	List<DashboardManage> list = service.dashboardChart();
        	List<String> categories = new ArrayList<>();
        	List<Long> dataValues = new ArrayList<>();
			
        	for(DashboardManage item : list) {
        		if(item.getOrderDate() != null) {  
	        		int month = Integer.parseInt(item.getOrderDate());
	            	categories.add(month + "월");
	            	dataValues.add(item.getPayment());
        		}
            }
            
            chartData.put("categories", categories);
            chartData.put("data", dataValues);
        	
		} catch (Exception e) {
			log.info("getChartData : ", e);
		}
        return chartData;
    }
	
	@ResponseBody
	@GetMapping("/packageChart")
	public Map<String, Object> getPackageChartData() throws Exception {
		Map<String, Object> chartData2 = new HashMap<>();
		
		try {
			List<DashboardManage> list2 = service.dashboardPackageChart();
			List<String> categories2 = new ArrayList<>();
			List<Long> dataValues2 = new ArrayList<>();
			
			for(DashboardManage item2 : list2) {
				if(item2.getPayDate() != null) {              
			        int month = Integer.parseInt(item2.getPayDate()); 
			        
			        categories2.add(month + "월");
			        dataValues2.add(item2.getTotalPay());
			    }
			}
			
			chartData2.put("categories", categories2);
			chartData2.put("data", dataValues2);
			
		} catch (Exception e) {
			log.info("getPackageChartData : ", e);
		}
		
		return chartData2;
	}
	
}
