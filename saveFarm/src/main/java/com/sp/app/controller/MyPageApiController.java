package com.sp.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sp.app.model.SessionInfo;
import com.sp.app.model.Wish;
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

	// 나의 찜 목록 데이터
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
	
	// 나의 찜 목록 데이터
	@GetMapping("/wish")
	public ResponseEntity<?> getMyWishList(HttpSession session) {
		Map<String, Object> body = new HashMap<>();
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			List<Wish> list = wishService.getWishList(info.getMemberId());
			body.put("list", list);
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("getProductList: ", e);
			body.put("message", "찜 목록을 불러오는 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}


}
