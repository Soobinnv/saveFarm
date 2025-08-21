package com.sp.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sp.app.common.PaginateUtil;
import com.sp.app.model.Product;
import com.sp.app.model.ProductQna;
import com.sp.app.model.ProductReview;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.ProductQnaService;
import com.sp.app.service.ProductReviewService;
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
	private final ProductReviewService reviewService;
	private final ProductQnaService qnaService;
	private final WishService wishService;
	private final PaginateUtil paginateUtil;

	// 상품 리스트 데이터
	@GetMapping("/normal")
	public ResponseEntity<?> getProductList(
			@RequestParam(name = "kwd", required = false, defaultValue = "") String kwd,
			@RequestParam(name = "pageNo", required = false, defaultValue = "1") int current_page,
			HttpSession session
		) {
		Map<String, Object> body = new HashMap<>();
		try {
			Map<String, Object> map = new HashMap<>();
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			if(info != null) {
				map.put("memberId", info.getMemberId());				
			}
			
			// 페이징 처리
			int size = 8;
			int total_page = 0;
			int dataCount = 0;
			
			dataCount = service.getDataCount(100);
			total_page = paginateUtil.pageCount(dataCount, size);
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			map.put("kwd", kwd);
						
			List<Product> productList = service.getProductList(map);
			
			body.put("productList", productList);
			body.put("dataCount", dataCount);
			body.put("pageNo", current_page);
			body.put("total_page", total_page);
			
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("getProductList: ", e);
			body.put("message", "일반 상품 목록을 불러오는 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}
	
	// 구출 상품 리스트 데이터
	@GetMapping("/rescued")
	public ResponseEntity<?> getRescuedProductList(
			@RequestParam(name = "kwd", required = false, defaultValue = "") String kwd,
			HttpSession session
			) {
		Map<String, Object> body = new HashMap<>();
		
		try {
			Map<String, Object> map = new HashMap<>();
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			if(info != null) {
				map.put("memberId", info.getMemberId());				
			}
			
			map.put("kwd", kwd);
			
			List<Product> rescuedProductList = service.getRescuedProductList(map);
			
			body.put("rescuedProductList", rescuedProductList);
;			
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("getRescuedProductList: ", e);
			body.put("message", "구출 상품 목록을 불러오는 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}

	// 상품 상세 데이터
	@GetMapping("/{productNum}")
	public ResponseEntity<?> getProductInfo(
			@PathVariable(name = "productNum") long productNum,
			@RequestParam(name = "classifyCode", required = false) int classifyCode,
			HttpSession session
		) {
		Map<String, Object> body = new HashMap<>();
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			long memberId = (info != null) ? info.getMemberId() : -1;
			
			Product productInfo = service.getProductWithDetails(productNum, classifyCode, memberId);
			
			if(productInfo == null) {
				body.put("message", "현제 상품의 상세 정보가 없습니다.");
				return ResponseEntity.status(HttpStatus.NOT_FOUND).body(body); // 404
			}
			
			// 추천 리스트 (수정 필요)
			List<Product> list = null;

			body.put("productInfo", productInfo);
			body.put("list", list);

			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("getProductInfo: ", e);
			body.put("message", "상품의 상세 정보를 불러오는 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}

	// 상품 문의 데이터
	@GetMapping("/{productNum}/qnas")
	public ResponseEntity<?> getProductQna(
			@PathVariable(name = "productNum") long productNum
		) {
		Map<String, Object> body = new HashMap<>();
		try {			
			List<ProductQna> list = qnaService.getQnaList(productNum); 
			
			body.put("list", list);
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("getProductQna: ", e);
			body.put("message", "상품의 문의 정보를 불러오는 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}
    
	// 상품 리뷰 데이터
	@GetMapping("/{productNum}/reviews")
	public ResponseEntity<?> getProductReview(
			@PathVariable(name = "productNum") long productNum,
			HttpSession session
		) {
		Map<String, Object> body = new HashMap<>();
		try {
			Map<String, Object> map = new HashMap<>();
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			if(info != null) {
				map.put("memberId", info.getMemberId());
			}
			
			map.put("offset", 0);
			map.put("size", 20);
			map.put("productNum", productNum);
			
			List<ProductReview> list = reviewService.getReviewListByProductNum(map);
			body.put("list", list);
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("getProductReview: ", e);
			body.put("message", "상품의 리뷰 정보를 불러오는 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}
	
	// 찜 등록
	@PostMapping("{productNum}/wishes")
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
	@DeleteMapping("{productNum}/wishes")
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

			// DB에서 가져온 시퀀스 값인 dto.qnaNum 클라이언트로 전송 // - 스크롤 구현 후 수정 필요
			body.put("qnaNum", dto.getQnaNum()); 

			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("insertProductQna: ", e);
			body.put("message", "상품 문의 등록 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}
	
}
