package com.sp.app.admin.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sp.app.admin.model.Claim;
import com.sp.app.admin.service.AdminClaimService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequiredArgsConstructor
@Slf4j
public class AdminClaimController {
	
	private final AdminClaimService claimService;
	
	// 클레임 리스트 데이터
	@GetMapping("/api/admin/claims")
	public ResponseEntity<?> getClaimList(
			@RequestParam(name = "type", required = false) String type,
			@RequestParam(name = "status", required = false) Integer status,
			@RequestParam(name = "pageNo", required = false, defaultValue = "1") int current_page
		) {
		Map<String, Object> body = new HashMap<>();
		try {			
			Map<String, Object> paramMap = new HashMap<>();
			
			// 페이징 정보
			int size = 10;
			int total_page = 0; 
			int dataCount = 0;
			
			paramMap.put("size", size);
			paramMap.put("total_page", total_page);
			paramMap.put("dataCount", dataCount);
			paramMap.put("current_page", current_page);
			
			paramMap.put("type", type);
			paramMap.put("status", status);

			Map<String, Object> ListAndPaging = claimService.getClaimListAndPaging(paramMap); 
			
			body.put("list", ListAndPaging.get("list"));
			
			body.put("dataCount", ListAndPaging.get("dataCount"));
			body.put("size", ListAndPaging.get("size"));
			body.put("total_page", ListAndPaging.get("total_page"));
			body.put("page", ListAndPaging.get("current_page"));
			
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("getClaimList: ", e);
			body.put("message", "클레임 목록 정보를 불러오는 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}
	
	// 클레임 데이터
	@GetMapping("/api/admin/claims/{num}")
	public ResponseEntity<?> getClaimInfo(
			@PathVariable("num") long num,
			@RequestParam(name = "type", required = false) String type
			) {
		Map<String, Object> body = new HashMap<>();
		try {			
			Map<String, Object> paramMap = new HashMap<>();

			paramMap.put("type", type);
			paramMap.put("num", num);
			
			Claim info = claimService.getClaimInfo(paramMap); 
			
			if(info == null) {
				body.put("message", "현재 클레임 상세 정보가 없습니다.");
				return ResponseEntity.status(HttpStatus.NOT_FOUND).body(body); // 404
			}
			
			switch (type) {
				case "refund": 
					body.put("info", info.getRefundObj());				
					break;
				
				case "return": 
					body.put("info", info.getReturnObj());				
					break;
				
				default:
					body.put("info", info);				
					break;
			}
			
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("getClaimInfo: ", e);
			body.put("message", "클레임 정보를 불러오는 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}
	
	// 클레임 상태 변경
	@PatchMapping("/api/admin/claims/{num}")
	public ResponseEntity<?> updateClaimStatus(
			@PathVariable("num") long num,
			Claim dto
			) {
		Map<String, Object> body = new HashMap<>();
		try {
			claimService.updateClaimState(dto);				
			
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("updateClaimStatus: ", e);
			body.put("message", "클레임 상태를 변경하던 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}
	
	// 클레임 삭제
	@DeleteMapping("/api/admin/claims/{num}")
	public ResponseEntity<?> deleteClaim(
			@PathVariable("num") long num,
			@RequestParam(name = "type", required = false) String type
			) {
		Map<String, Object> body = new HashMap<>();
		try {
			claimService.deleteClaim(num, type);				
			
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("updateClaimStatus: ", e);
			body.put("message", "클레임 내역을 삭제하던 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}
	
	
	
}
