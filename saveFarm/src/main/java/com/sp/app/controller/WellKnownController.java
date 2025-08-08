package com.sp.app.controller;

import java.net.URI;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpServletRequest;

/*
  - No static resource .well-known/appspecific/com.chrome.devtools.json 에러 해결을 위한 컨트롤러
    브라우저(특히 Chrome 개발자 도구)가 디버깅이나 PWA(Progressive Web App) 관련 정보 또는 특정 인증 정보를 확인하기 위해 사용
 */

@Controller
public class WellKnownController {
	@GetMapping("/.well-known/appspecific/com.chrome.devtools.json")
	public ResponseEntity<?> handle(HttpServletRequest req) {
		String redirectUrl = req.getContextPath() + "/";
		return ResponseEntity
				.status(HttpStatus.FOUND)  // 302 상태 코드(리다이렉트)
				.location(URI.create(redirectUrl))  // Location 헤더에 리다이렉트할 URL 설정
				.build();
	}
}

/*
@RestController
public class WellKnownController {
	@GetMapping("/.well-known/appspecific/com.chrome.devtools.json")
	public ResponseEntity<Map<String, Object>> serveDevtoolsJson() {
		Map<String, Object> data = new HashMap<>();
		data.put("example", "value");
		return ResponseEntity.ok(data);
	}
}
*/