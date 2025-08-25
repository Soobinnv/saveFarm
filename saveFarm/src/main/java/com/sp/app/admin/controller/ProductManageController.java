package com.sp.app.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sp.app.common.PaginateUtil;
import com.sp.app.farm.model.Supply;
import com.sp.app.farm.service.SupplyService;
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
	private final SupplyService supplyService;
	private final ProductQnaService productQnaService;
	private final ProductReviewService productReviewService;
	private final PaginateUtil paginateUtil;
	
	// 상품 리스트 데이터
	@GetMapping("/api/admin/products")
	public ResponseEntity<?> getProducts(
			@RequestParam(name = "classifyCode", required = false) Integer classifyCode,
			@RequestParam(name = "pageNo", required = false, defaultValue = "1") int current_page,
			@RequestParam(name = "schType", required = false, defaultValue = "all") String schType,
			@RequestParam(name = "kwd", required = false, defaultValue = "") String kwd
		) {
		Map<String, Object> body = new HashMap<>();
		try {			
			Map<String, Object> paramMap = new HashMap<>();
			
			// 페이징 처리
			int size = 10;
			int total_page = 0; 
			int dataCount = 0;
			
			dataCount = productService.getDataCount(classifyCode);
			total_page = paginateUtil.pageCount(dataCount, size);
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			paramMap.put("offset", offset);
			paramMap.put("size", size);
			
			paramMap.put("classifyCode", classifyCode);
			paramMap.put("schType", schType);
			paramMap.put("kwd", kwd);

			// 관리자 페이지용 조회
			paramMap.put("pageType", "admin");
			
			List<Product> list = productService.getProducts(paramMap); 
			
			body.put("list", list);
			
			body.put("dataCount", dataCount);
			body.put("size", size);
			body.put("total_page", total_page);
			body.put("page", current_page);
			
			body.put("schType", schType);
			body.put("kwd", kwd);
			
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("getProducts: ", e);
			body.put("message", "상품 정보를 불러오는 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}
	
	// 상품 상세 데이터
	@GetMapping("/api/admin/products/{productNum}")
	public ResponseEntity<?> getProductInfo(
			@PathVariable(name = "productNum") long productNum
		) {
		Map<String, Object> body = new HashMap<>();
		
		try {
			Product productInfo = productService.getProductAllInfo(productNum);
			
			body.put("productInfo", productInfo);

			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("getProductInfo: ", e);
			body.put("message", "상품의 상세 정보를 불러오는 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}
	
	// 상품 등록
	@PostMapping("/api/admin/products")
	public ResponseEntity<?> insertProduct(
			Product dto
			) {
		Map<String, Object> body = new HashMap<>();
		
		try {
			productService.insertProductWithDetails(dto, null);
			
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("updateProduct: ", e);
			body.put("message", "상품 등록 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}
	
	// 상품 수정
	@PutMapping("/api/admin/products/{productNum}")
	public ResponseEntity<?> updateProduct(
			@PathVariable(name = "productNum") long productNum,
			Product dto
			) {
		Map<String, Object> body = new HashMap<>();
		
		try {
			productService.updateProductWithDetails(dto, null);
			
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("updateProduct: ", e);
			body.put("message", "상품 수정 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}
	
	// 납품 데이터
	@GetMapping("/api/admin/supplies")
	public ResponseEntity<?> getSupplies(
			@RequestParam(name = "state", required = false) Integer state,
			@RequestParam(name = "pageNo", required = false, defaultValue = "1") int current_page,
			@RequestParam(name = "schType", required = false, defaultValue = "all") String schType,
			@RequestParam(name = "kwd", required = false, defaultValue = "") String kwd
		) {
		Map<String, Object> body = new HashMap<>();
		try {			
			Map<String, Object> paramMap = new HashMap<>();

			// 페이징 처리
			int size = 10;
			int total_page = 0; 
			int dataCount = 0;
			
			dataCount = supplyService.listSupplyCount(paramMap);
			total_page = paginateUtil.pageCount(dataCount, size);
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			paramMap.put("offset", offset);
			paramMap.put("size", size);
			
			paramMap.put("kwd", kwd);
			paramMap.put("state", state);
			
			List<Supply> list = supplyService.listManageSupply(paramMap); 
			
			body.put("list", list);
			
			body.put("dataCount", dataCount);
			body.put("size", size);
			body.put("total_page", total_page);
			body.put("page", current_page);

			body.put("schType", schType);
			body.put("kwd", kwd);
			
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
			@RequestParam(name = "isAnswerd", required = false) Integer isAnswerd,
			@RequestParam(name = "pageNo", required = false, defaultValue = "1") int current_page,
			@RequestParam(name = "schType", required = false, defaultValue = "all") String schType,
			@RequestParam(name = "kwd", required = false, defaultValue = "") String kwd
		) {
		Map<String, Object> body = new HashMap<>();
		try {			
			Map<String, Object> paramMap = new HashMap<>();
			
			// 페이징 처리
			int size = 10;
			int total_page = 0; 
			int dataCount = 0;
			
			paramMap.put("isAnswerd", isAnswerd);
			
			dataCount = productQnaService.getDataCount(paramMap);
			total_page = paginateUtil.pageCount(dataCount, size);
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			paramMap.put("offset", offset);
			paramMap.put("size", size);
			
			paramMap.put("kwd", kwd);
			
			List<ProductQna> list = productQnaService.getAllQnaList(paramMap); 
			
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
	
	// 상품 문의 상세 데이터
	@GetMapping("/api/admin/inquiries/{qnanum}")
	public ResponseEntity<?> getQnaInfo(
			@PathVariable(name = "qnanum") long qnanum
			) {
		Map<String, Object> body = new HashMap<>();
		
		try {
			ProductQna productQnaInfo = productQnaService.findByQnaNum(qnanum);
			
			if(productQnaInfo == null) {
				body.put("message", "현제 상품 문의 상세 정보가 없습니다.");
				return ResponseEntity.status(HttpStatus.NOT_FOUND).body(body); // 404
			}
			
			body.put("productQnaInfo", productQnaInfo);
			
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("getProductInfo: ", e);
			body.put("message", "상품 문의 상세 정보를 불러오는 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}
	
	// 상품 리뷰 데이터
	@GetMapping("/api/admin/reviews")
	public ResponseEntity<?> getReviews(
			@RequestParam(name = "reviewBlock", required = false) Integer reviewBlock,
			@RequestParam(name = "pageNo", required = false, defaultValue = "1") int current_page,
			@RequestParam(name = "schType", required = false, defaultValue = "all") String schType,
			@RequestParam(name = "kwd", required = false, defaultValue = "") String kwd
		) {
		Map<String, Object> body = new HashMap<>();
		try {			
			Map<String, Object> paramMap = new HashMap<>();
			
			// 페이징 처리
			int size = 10;
			int total_page = 0; 
			int dataCount = 0;
			
			paramMap.put("reviewBlock", reviewBlock);
			
			dataCount = productReviewService.getDataCount(paramMap);
			total_page = paginateUtil.pageCount(dataCount, size);
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			paramMap.put("offset", offset);
			paramMap.put("size", size);
			
			paramMap.put("kwd", kwd);
			
			List<ProductReview> list = productReviewService.getReviewList(paramMap); 
			
			body.put("list", list);
			
			body.put("dataCount", dataCount);
			body.put("size", size);
			body.put("total_page", total_page);
			body.put("page", current_page);
			
			body.put("schType", schType);
			body.put("kwd", kwd);
			
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("getReviews: ", e);
			body.put("message", "리뷰 정보를 불러오는 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}
	
	// 상품 리뷰 상세 데이터
	@GetMapping("/api/admin/reviews/{orderDetailNum}")
	public ResponseEntity<?> getReviewInfo(
			@PathVariable(name = "orderDetailNum") long orderDetailNum
			) {
		Map<String, Object> body = new HashMap<>();
		
		try {
			ProductReview productReviewInfo = productReviewService.findByOrderDetailNum(orderDetailNum);
			
			if(productReviewInfo == null) {
				body.put("message", "현제 상품 리뷰 상세 정보가 없습니다.");
				return ResponseEntity.status(HttpStatus.NOT_FOUND).body(body); // 404
			}
			
			body.put("productReviewInfo", productReviewInfo);
			
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("getProductInfo: ", e);
			body.put("message", "상품 리뷰 상세 정보를 불러오는 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}
	
	// 상품 리뷰 상태 변경
	@PutMapping("/api/admin/reviews/{orderDetailNum}")
	public ResponseEntity<?> updateReviewBlock(
			@PathVariable(name = "orderDetailNum") long orderDetailNum,
			@RequestParam(name = "reviewBlock") int reviewBlock
			) {
		Map<String, Object> body = new HashMap<>();
		
		try {
			productReviewService.updateReviewBlockStatus(orderDetailNum, reviewBlock);
			
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("updateReviewBlock: ", e);
			body.put("message", "상품 리뷰 상태 수정 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}
	
	// 상품 리뷰 삭제
	@DeleteMapping("/api/admin/reviews/{orderDetailNum}")
	public ResponseEntity<?> deleteReview(
			@PathVariable(name = "orderDetailNum") long orderDetailNum
			) {
		Map<String, Object> body = new HashMap<>();
		
		try {
			productReviewService.deleteReview(orderDetailNum, null);
			
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("deleteReview: ", e);
			body.put("message", "상품 리뷰 삭제 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}
	
	
}
