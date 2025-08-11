package com.sp.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.model.Product;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.ProductService;
import com.sp.app.service.WishService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/product/")
public class ProductController {

	private final ProductService service;
	private final WishService wishService;
	
	// 상품 리스트
	@GetMapping("list")
	public String list(Model model) {
		
		try {
			
			Map<String, Object> map = new HashMap<String, Object>();
			
			List<Product> list = service.getProductList(map);
			
			model.addAttribute("list", list);
			
		} catch (Exception e) {
		
		}
		
		return "product/list";
	}
	
	// 상품 정보
	@GetMapping("{productNum}")
	public String productInfo(
			@PathVariable("productNum") long productNum,
			HttpSession session, 
			Model model
		) throws Exception {
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			Product productInfo = Objects.requireNonNull(service.getProductInfo(productNum));

			if(info != null) {
				// 회원의 찜 여부
				Map<String, Object> map = new HashMap<>();
				map.put("memberId", info.getMemberId());
				map.put("productNum", productInfo.getProductNum());
				
				productInfo.setUserWish(wishService.findByWishId(map) == null ? 0 : 1);
			}
			
			model.addAttribute("productInfo", productInfo);
			
			return "product/info";
			
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("productDetail : ", e);
		}

		return "redirect:/product/list";
	}
	
	// 상품 문의 - AJAX-JSON
	@GetMapping("{productNum}/productQna")
	@ResponseBody
	public List<Product> getProductQna(@PathVariable("productNum") long productNum) {
		
		return null;
	}
	
	// 상품 환물/반품 - AJAX-JSON
	@GetMapping("{productNum}/productRefund")
	@ResponseBody
	public List<Product> getProductRefund(@PathVariable("productNum") long productNum) {
		
		return null;
	}
	
	// 상품 리뷰 - AJAX-JSON
	@GetMapping("{productNum}/productReview")
	@ResponseBody
	public List<Product> getProductReview(@PathVariable("productNum") long productNum) {
		
		return null;
	}
	
	// 찜 등록 - AJAX-JSON
	@PostMapping("{productNum}/wish")
	@ResponseBody
	public Map<String, ?> wishSubmit(
			@PathVariable(name = "productNum") Long productNum,
			HttpSession session
		) throws Exception {
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		String state = "false";
		
		try {
			Map<String, Object> map = new HashMap<>();
			
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			map.put("memberId", info.getMemberId());
			map.put("productNum", productNum);
			
			wishService.insertWish(map);
			
			state = "true";
		} catch (Exception e) {
		}
		
		model.put("state", state);
		return model;
	}	

	// 찜 삭제 - AJAX-JSON
	@DeleteMapping("{productNum}/wish")
	@ResponseBody
	public Map<String, ?> wishDelete(
			@PathVariable(name = "productNum") Long productNum,
			HttpSession session
		) throws Exception {
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		String state = "false";
		
		try {
			Map<String, Object> map = new HashMap<>();
			
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			map.put("memberId", info.getMemberId());
			map.put("productNum", productNum);
			
			wishService.deleteWish(map);
			
			state = "true";
		} catch (Exception e) {
		}
		
		model.put("state", state);
		return model;
	}
}
