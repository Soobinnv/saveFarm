package com.sp.app.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sp.app.model.SessionInfo;
import com.sp.app.service.ProductReviewService;


import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController 
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/api/reviews")
public class ReviewApiController {

	private final ProductReviewService reviewService;

	// 리뷰 추천
	@PostMapping("/{orderDetailNum}/like")
	public ResponseEntity<?> insertReviewLike(
			@PathVariable(name = "orderDetailNum") Long orderDetailNum,
			HttpSession session
		) {
		Map<String, Object> body = new HashMap<>();
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if (info == null) {
				return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(body); // 401 Unauthorized
			}
			
			Map<String, Object> map = new HashMap<>();
			map.put("memberId", info.getMemberId());
			map.put("orderDetailNum", orderDetailNum);
			reviewService.insertReviewLike(map);
			
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("insertReviewLike: ", e);
			body.put("message", "리뷰 추천 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}

	// 리뷰 추천 취소
	@DeleteMapping("/{orderDetailNum}/like")
	public ResponseEntity<?> deleteReviewLike(
			@PathVariable(name = "orderDetailNum") Long orderDetailNum,
			HttpSession session
		) {
		Map<String, Object> body = new HashMap<>();
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if (info == null) {
				return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(body); // 401 Unauthorized
			}

			Map<String, Object> map = new HashMap<>();
			map.put("memberId", info.getMemberId());
			map.put("orderDetailNum", orderDetailNum);
			reviewService.deleteReviewLike(map);

			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("deleteReviewLike: ", e);
			body.put("message", "리뷰 추천 취소 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}

	
}
