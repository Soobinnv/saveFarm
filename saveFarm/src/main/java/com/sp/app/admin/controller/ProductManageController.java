package com.sp.app.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sp.app.model.ProductQna;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequiredArgsConstructor
@Slf4j
public class ProductManageController {
	
	// 상품 데이터
	@GetMapping("/api/admin/products")
	public ResponseEntity<?> getProducts(Model model) {
		Map<String, Object> body = new HashMap<>();
		try {			
			List<ProductQna> list = null; 
			
			body.put("list", list);
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("getProductQnas: ", e);
			body.put("message", "상품 정보를 불러오는 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}
	
	// 납품 리스트 데이터
	@GetMapping("/api/admin/supplies")
	public ResponseEntity<?> getSupplies(Model model) {
		Map<String, Object> body = new HashMap<>();
		try {			
			List<ProductQna> list = null; 
			
			body.put("list", list);
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("getProductQnas: ", e);
			body.put("message", "농가 납품 정보를 불러오는 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}
	
	// 상품 문의 리스트 데이터
	@GetMapping("/api/admin/inquiries")
	public ResponseEntity<?> getInquiries(Model model) {
		Map<String, Object> body = new HashMap<>();
		try {			
			List<ProductQna> list = null; 
			
			body.put("list", list);
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("getProductQnas: ", e);
			body.put("message", "문의 정보를 불러오는 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}
	
	@GetMapping("/api/admin/reviews")
	public ResponseEntity<?> getReviews(Model model) {
		Map<String, Object> body = new HashMap<>();
		try {			
			List<ProductQna> list = null; 
			
			body.put("list", list);
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("getProductQnas: ", e);
			body.put("message", "리뷰 정보를 불러오는 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}
	
	
	
}
