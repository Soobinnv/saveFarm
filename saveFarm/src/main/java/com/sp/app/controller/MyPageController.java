package com.sp.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.common.PaginateUtil;
import com.sp.app.model.Order;
import com.sp.app.model.Payment;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.MyPageService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/myPage/*")
public class MyPageController {
	private final MyPageService service;
	private final PaginateUtil paginateUtil;
	
	// 결제내역
	@GetMapping("/paymentList")
	public String paymentList(@RequestParam(name = "page", defaultValue = "1") int current_page,
			Model model,
			HttpServletRequest req,
			HttpSession session) throws Exception {
		
		try {
			int size = 10;
			int total_page;
			int dataCount;
			
			SessionInfo info = (SessionInfo)session.getAttribute("member");

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("memberId", info.getMemberId());
			
			dataCount = service.countPayment(map);
			total_page = paginateUtil.pageCount(dataCount, size);
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			List<Payment> list = service.listPayment(map);
			
			String cp = req.getContextPath();
			String listUrl = cp + "/myPage/paymentList";
			
			String paging = paginateUtil.paging(current_page, total_page, listUrl);
			
			model.addAttribute("list", list);
			model.addAttribute("page", current_page);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("size", size);
			model.addAttribute("total_page", total_page);
			model.addAttribute("paging", paging);		
			
		} catch (Exception e) {
			log.info("paymentList : ", e);
		}
		
		return "myPage/paymentList";
	}
	
	// 구매 상세 보기 : AJAX - Text
	@GetMapping("detailView")
	public String detailView(@RequestParam Map<String, Object> paramMap,
			Model model,
			HttpServletResponse resp,
			HttpSession session) throws Exception {
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			paramMap.put("memberId", info.getMemberId());
			
			// 구매 상세 정보
			Payment dto = service.findByOrderDetail(paramMap);
			
			// 퍼처스 리스트(함께 구매한 상품 리스트)
			List<Payment> listBuy = service.listPurchase(paramMap);
			
			// 배송지 정보
			Order orderDelivery = service.findByOrderDelivery(paramMap);
			
			model.addAttribute("dto", dto);
			model.addAttribute("listBuy", listBuy);
			model.addAttribute("orderDelivery", orderDelivery);
			
		} catch (Exception e) {
			resp.sendError(406);
			
			throw e;
		}
		
		return "myPage/orderDetailView"; 
	}
	
	// 구매 확정
	@GetMapping("confirmation")
	public String confirmation(@RequestParam Map<String, Object> paramMap,
			@RequestParam(name = "page") String page,
			HttpSession session) throws Exception {
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			paramMap.put("detailState", "1"); // 구매확정
			paramMap.put("stateMemo", "구매확정완료");
			paramMap.put("memberId", info.getMemberId());
			
			service.updateOrderDetailState(paramMap);
			
		} catch (Exception e) {
			log.info("confirmation : ", e);
		}
		
		return "redirect:/myPage/paymentList?page="+page; 
	}
	
	// 주문취소/반품/교환요청
	@PostMapping("orderDetailUpdate")
	public String orderDetailUpdate(@RequestParam Map<String, Object> paramMap,
			@RequestParam(name = "page") String page,
			HttpSession session) throws Exception {
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			paramMap.put("memberId", info.getMemberId());
			
			service.updateOrderDetailState(paramMap);
			
		} catch (Exception e) {
			log.info("orderDetailUpdate : ", e);
		}
		
		return "redirect:/myPage/paymentList?page="+page;
	}
	
	@GetMapping("updateOrderHistory")
	public String updateOrderHistory(@RequestParam(name = "orderDetailNum") long orderDetailNum,
			@RequestParam(name = "page") String page,
			HttpSession session) throws Exception {
		
		try {
			service.updateOrderHistory(orderDetailNum);
		} catch (Exception e) {
		}
		
		return "redirect:/myPage/paymentList?page="+page;
	}
	
}
