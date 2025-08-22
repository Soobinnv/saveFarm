package com.sp.app.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sp.app.common.PaginateUtil;
import com.sp.app.model.Product;
import com.sp.app.model.ProductQna;
import com.sp.app.model.ProductReview;
import com.sp.app.service.ProductQnaService;
import com.sp.app.service.ProductReviewService;
import com.sp.app.service.ProductService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequiredArgsConstructor
@Slf4j
public class ProductManageController {
	
	private final ProductService productService;
	// private final SupplyService supplyService;
	private final ProductQnaService productQnaService;
	private final ProductReviewService productReviewService;
	private final PaginateUtil paginateUtil;
	
	// 상품 데이터
	@GetMapping("/api/admin/products")
	public ResponseEntity<?> getProducts(
			@RequestParam(name = "pageNo", required = false, defaultValue = "1") int current_page,
			@RequestParam(name = "schType", required = false, defaultValue = "all") String schType,
			@RequestParam(name = "kwd", required = false, defaultValue = "") String kwd
		) {
		Map<String, Object> body = new HashMap<>();
		try {			
			Map<String, Object> map = new HashMap<>();
			
			// 페이징 처리
			int size = 10;
			int total_page = 0; 
			int dataCount = 0;
			
			dataCount = productService.getAllDataCount();
			total_page = paginateUtil.pageCount(dataCount, size);
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			map.put("kwd", kwd);
			
			List<Product> list = productService.getAllProductList(map); 
			
			body.put("list", list);
			
			body.put("dataCount", dataCount);
			body.put("size", size);
			body.put("total_page", total_page);
			body.put("page", current_page);
			
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("getProducts: ", e);
			body.put("message", "상품 정보를 불러오는 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}
	
	// 납품 데이터
	@GetMapping("/api/admin/supplies")
	public ResponseEntity<?> getSupplies(
			@RequestParam(name = "pageNo", required = false, defaultValue = "1") int current_page,
			@RequestParam(name = "schType", required = false, defaultValue = "all") String schType,
			@RequestParam(name = "kwd", required = false, defaultValue = "") String kwd
		) {
		Map<String, Object> body = new HashMap<>();
		try {			
			Map<String, Object> map = new HashMap<>();

			// 페이징 처리
			int size = 10;
			int total_page = 0; 
			int dataCount = 0;
			
			// dataCount = supplyService.getAllDataCount();
			total_page = paginateUtil.pageCount(dataCount, size);
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			map.put("kwd", kwd);
			
			// List<Product> list = supplyService.getAllProductList(map); 
			
			// body.put("list", list);
			
			body.put("dataCount", dataCount);
			body.put("size", size);
			body.put("total_page", total_page);
			body.put("page", current_page);

			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("getSupplies: ", e);
			body.put("message", "농가 납품 정보를 불러오는 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}
	
	// 상품 문의 데이터
	@GetMapping("/api/admin/inquiries")
	public ResponseEntity<?> getInquiries(
			@RequestParam(name = "pageNo", required = false, defaultValue = "1") int current_page,
			@RequestParam(name = "schType", required = false, defaultValue = "all") String schType,
			@RequestParam(name = "kwd", required = false, defaultValue = "") String kwd
		) {
		Map<String, Object> body = new HashMap<>();
		try {			
			Map<String, Object> map = new HashMap<>();
			
			// 페이징 처리
			int size = 10;
			int total_page = 0; 
			int dataCount = 0;
			
			dataCount = productQnaService.getAllDataCount();
			total_page = paginateUtil.pageCount(dataCount, size);
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			map.put("kwd", kwd);
			
			List<ProductQna> list = productQnaService.getAllQnaList(map); 
			
			body.put("list", list);
			
			body.put("dataCount", dataCount);
			body.put("size", size);
			body.put("total_page", total_page);
			body.put("page", current_page);
			
			body.put("schType", schType);
			body.put("kwd", kwd);

			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("getInquiries: ", e);
			body.put("message", "문의 정보를 불러오는 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}
	
	// 상품 리뷰 데이터
	@GetMapping("/api/admin/reviews")
	public ResponseEntity<?> getReviews(
			@RequestParam(name = "pageNo", required = false, defaultValue = "1") int current_page,
			@RequestParam(name = "schType", required = false, defaultValue = "all") String schType,
			@RequestParam(name = "kwd", required = false, defaultValue = "") String kwd
		) {
		Map<String, Object> body = new HashMap<>();
		try {			
			Map<String, Object> map = new HashMap<>();
			
			// 페이징 처리
			int size = 10;
			int total_page = 0; 
			int dataCount = 0;
			
			dataCount = productReviewService.getAllDataCount();
			total_page = paginateUtil.pageCount(dataCount, size);
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			map.put("kwd", kwd);
			
			List<ProductReview> list = productReviewService.getReviewList(map); 
			
			body.put("list", list);
			
			body.put("dataCount", dataCount);
			body.put("size", size);
			body.put("total_page", total_page);
			body.put("page", current_page);
			
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("getReviews: ", e);
			body.put("message", "리뷰 정보를 불러오는 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}
	
	
	
}
