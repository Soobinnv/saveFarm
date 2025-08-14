package com.sp.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sp.app.common.PaginateUtil;
import com.sp.app.model.ProductQna;
import com.sp.app.model.ProductReview;
import com.sp.app.model.SessionInfo;
import com.sp.app.model.Wish;
import com.sp.app.service.ProductQnaService;
import com.sp.app.service.WishService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController 
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/api/myPage")
public class MyPageApiController {

	private final WishService wishService;
	private final ProductQnaService qnaService;
	private final PaginateUtil paginateUtil;
	
	// 마이페이지 - 메인 데이터
	@GetMapping
	public ResponseEntity<?> getMyPageMain(HttpSession session) {
		Map<String, Object> body = new HashMap<>();
		try {
			
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("getMyPageMain: ", e);
			body.put("message", "마이페이지 - 메인을 불러오는 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}
	
	// 내 활동 - 찜 데이터
	@GetMapping("/wish")
	public ResponseEntity<?> getMyWishList(HttpSession session) {
		Map<String, Object> body = new HashMap<>();
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			List<Wish> list = wishService.getWishList(info.getMemberId());
			body.put("list", list);
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("getMyWishList: ", e);
			body.put("message", "나의 찜 목록을 불러오는 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}
	
	// 내 활동 - 나의 리뷰 데이터
	@GetMapping("/reviews")
	public ResponseEntity<?> getMyReviewList(HttpSession session) {
		Map<String, Object> body = new HashMap<>();
		try {
			
			
			List<ProductReview> list = null;
			body.put("list", list);
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("getMyReviewList: ", e);
			body.put("message", "나의 리뷰 정보를 불러오는 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}
	// 내 활동 - 1:1 문의 데이터
	@GetMapping("/inquirys")
	public ResponseEntity<?> getMyInquiryList(HttpSession session) {
		Map<String, Object> body = new HashMap<>();
		try {
			
			
			List<ProductQna> list = null;
			
			body.put("list", list);
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("getMyInquiryList: ", e);
			body.put("message", "나의 1:1 문의 정보를 불러오는 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}
	
	// 내 활동 - 상품 문의 데이터
	@GetMapping("/qnas")
	public ResponseEntity<?> getMyQnaList(HttpSession session, @RequestParam(name = "pageNo", defaultValue = "1") int current_page) {
		Map<String, Object> body = new HashMap<>();
		Map<String, Object> map = new HashMap<>();

		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			int size = 10;
			int total_page = 0;
			int dataCount = 0;
			
			dataCount = qnaService.getMyQnaDataCount(info.getMemberId());
			total_page = paginateUtil.pageCount(dataCount, size);
			current_page = Math.min(current_page, total_page);
			
			// 리스트에 출력할 데이터를 가져오기
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			map.put("memberId", info.getMemberId());
			
			List<ProductQna> list = qnaService.getMyQnaList(map);
			
			// AJAX 용 페이징
			String paging = paginateUtil.pagingMethod(current_page, total_page, "listPage");
			
			body.put("list", list);
			body.put("pageNo", current_page);
			body.put("replyCount", dataCount);
			body.put("total_page", total_page);
			body.put("paging", paging);
			
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("getMyQnaList: ", e);
			body.put("message", "나의 상품 문의 정보를 불러오는 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}
	// 내 활동 - FAQ 데이터
	@GetMapping("/faqs")
	public ResponseEntity<?> getMyFaqList(HttpSession session) {
		Map<String, Object> body = new HashMap<>();
		try {
			
			
			List<ProductReview> list = null;
			body.put("list", list);
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("getMyFaqList: ", e);
			body.put("message", "FAQ 정보를 불러오는 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}


}
