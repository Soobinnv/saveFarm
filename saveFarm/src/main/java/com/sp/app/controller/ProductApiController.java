package com.sp.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sp.app.model.Product;
import com.sp.app.model.ProductQna;
import com.sp.app.model.ProductReview;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.ProductQnaService;
import com.sp.app.service.ProductService;
import com.sp.app.service.WishService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController 
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/api/products")
public class ProductApiController {

	private final ProductService service;
	private final ProductQnaService qnaService;
	private final WishService wishService;

	// 상품 리스트 데이터
	@GetMapping
	public ResponseEntity<?> getProductList(@RequestParam(name = "kwd", required = false, defaultValue = "") String kwd, HttpSession session) {
		Map<String, Object> body = new HashMap<>();
		try {
			Map<String, Object> map = new HashMap<>();
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			
			if(info != null) {
				map.put("memberId", info.getMemberId());				
			}
			
			map.put("kwd", kwd);
			
			List<Product> list = service.getProductList(map);
			body.put("list", list);
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("getProductList: ", e);
			body.put("message", "상품 목록을 불러오는 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}

	// 상품 상세 데이터
	@GetMapping("/{productNum}")
	public ResponseEntity<?> getProductInfo(@PathVariable(name = "productNum") long productNum) {
		Map<String, Object> body = new HashMap<>();
		try {
			Product productInfo = Objects.requireNonNull(service.getProductInfo(productNum));

			// 추천 리스트 (수정 필요)
			List<Product> list = null;

			body.put("productInfo", productInfo);
			body.put("list", list);
			return ResponseEntity.ok(body); // 200 OK

		} catch (NullPointerException e) {
			return ResponseEntity.notFound().build(); // 404 Not Found
		} catch (Exception e) {
			log.error("getProductInfo: ", e);
			body.put("message", "상품 정보를 불러오는 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}

	// 상품 문의 데이터
	@GetMapping("/{productNum}/qnas")
	public ResponseEntity<?> getProductQna(@PathVariable(name = "productNum") long productNum) {
		Map<String, Object> body = new HashMap<>();
		try {
			Map<String, Object> map = new HashMap<>();
			
			
			map.put("offset", 0);
			map.put("size", 20);
			map.put("productNum", productNum);
			
			List<ProductQna> list = qnaService.getQnaList(map); 
			body.put("list", list);
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("getProductQna: ", e);
			body.put("message", "문의 정보를 불러오는 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}
    
	// 상품 리뷰 데이터
	@GetMapping("/{productNum}/reviews")
	public ResponseEntity<?> getProductReview(@PathVariable(name = "productNum") long productNum) {
		Map<String, Object> body = new HashMap<>();
		try {
			List<ProductReview> list = null;
			body.put("list", list);
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("getProductReview: ", e);
			body.put("message", "리뷰 정보를 불러오는 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}

	// 상품 환불/반품 데이터
	@GetMapping("/{productNum}/refund-info")
	public ResponseEntity<?> getProductRefundInfo(@PathVariable(name = "productNum") long productNum) {
		Map<String, Object> body = new HashMap<>();
		try {
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("getProductRefundInfo: ", e);
			body.put("message", "환불/반품 정보를 불러오는 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}

	// 찜 등록
	@PostMapping("{productNum}/wish")
	public ResponseEntity<?> insertWish(
			@PathVariable(name = "productNum") Long productNum,
			HttpSession session) {
		Map<String, Object> body = new HashMap<>();
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if (info == null) {
				return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(body); // 401 Unauthorized
			}

			Map<String, Object> map = new HashMap<>();
			map.put("memberId", info.getMemberId());
			map.put("productNum", productNum);
			wishService.insertWish(map);

			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("insertWish: ", e);
			body.put("message", "찜 등록 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}

	// 찜하기 취소
	@DeleteMapping("{productNum}/wish")
	public ResponseEntity<?> deleteWish(
			@PathVariable(name = "productNum") Long productNum,
			HttpSession session) {
		Map<String, Object> body = new HashMap<>();
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if (info == null) {
				return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(body); // 401 Unauthorized
			}

			Map<String, Object> map = new HashMap<>();
			map.put("memberId", info.getMemberId());
			map.put("productNum", productNum);
			wishService.deleteWish(map);

			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("deleteWish: ", e);
			body.put("message", "찜 취소 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}
	
	// 상품 문의 등록
	@PostMapping("{productNum}/qnas")
	public ResponseEntity<?> insertProductQna(
			@PathVariable(name = "productNum") Long productNum,
			ProductQna dto,
			HttpSession session) {
		Map<String, Object> body = new HashMap<>();
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if (info == null) {
				return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(body); // 401 Unauthorized
			}

			dto.setMemberId(info.getMemberId());
			dto.setProductNum(productNum);

			qnaService.insertQna(dto);

			// DB에서 가져온 시퀀스 값인 dto.qnaNum 클라이언트로 전송
			body.put("qnaNum", dto.getQnaNum()); 

			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("insertProductQna: ", e);
			body.put("message", "상품 문의 등록 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}
	
}
