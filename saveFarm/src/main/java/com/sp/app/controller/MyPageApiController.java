package com.sp.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sp.app.common.PaginateUtil;
import com.sp.app.common.StorageService;
import com.sp.app.model.Order;
import com.sp.app.model.PackageOrder;
import com.sp.app.model.Payment;
import com.sp.app.model.ProductQna;
import com.sp.app.model.ProductReview;
import com.sp.app.model.Refund;
import com.sp.app.model.Return;
import com.sp.app.model.SessionInfo;
import com.sp.app.model.Wish;
import com.sp.app.service.MyPageService;
import com.sp.app.service.ProductQnaService;
import com.sp.app.service.ProductReviewService;
import com.sp.app.service.RefundService;
import com.sp.app.service.ReturnService;
import com.sp.app.service.WishService;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController 
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/api/myPage")
public class MyPageApiController {
	private final MyPageService mypageService;
	private final WishService wishService;
	private final ProductQnaService qnaService;
	private final ProductReviewService reviewService;
	private final PaginateUtil paginateUtil;
	private final StorageService storageService;
	private final ReturnService returnService;
	private final RefundService refundService;
	
	private String productReviewUploadPath;
	
	@PostConstruct
	public void init() {
		productReviewUploadPath = this.storageService.getRealPath("/uploads/productReview");		
	}	
	
	// 마이페이지 - 메인 데이터(결제내역)
	@GetMapping("/paymentList")
	public ResponseEntity<?> paymentList(@RequestParam(name = "pageNo", defaultValue = "1") int current_page,
			Order dto,
			HttpSession session) {
		Map<String, Object> body = new HashMap<>();
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			// 페이징 처리
			int size = 10;
			int total_page = 0;
			int dataCount = 0;
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("memberId", info.getMemberId());
			
			dataCount = mypageService.countPayment(map);
			total_page = paginateUtil.pageCount(dataCount, size);
			current_page = Math.min(current_page, total_page);
			
			// 리스트 출력 데이터 가져오기
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			List<Payment> list = mypageService.listPayment(map);
			
			// AJAX 용 페이징 처리
			String paging = paginateUtil.paging(current_page, total_page, "paymentListPage");
			
			body.put("list", list);
			body.put("pageNo", current_page);
			body.put("dataCount", dataCount);
			body.put("size", size);
			body.put("total_page", total_page);
			body.put("paging", paging);		
			
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("paymentList: ", e);
			body.put("message", "마이페이지 - 메인을 불러오는 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
	
		}
	}
	
	// 구매 상세 보기 : AJAX - Text
	@GetMapping("/detailView")
	public ResponseEntity<?> detailView(@RequestParam Map<String, Object> paramMap,
			HttpServletResponse resp,
			HttpSession session) throws Exception {
		Map<String, Object> body = new HashMap<>();
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			paramMap.put("memberId", info.getMemberId());
			
			// 구매 상세 정보
			Payment dto = mypageService.findByOrderDetail(paramMap);
			
			// 퍼처스 리스트(함께 구매한 상품 리스트)
			List<Payment> listBuy = mypageService.listPurchase(paramMap);
			
			// 배송지 정보
			Order orderDelivery = mypageService.findByOrderDelivery(paramMap);
			
			body.put("dto", dto);
			body.put("listBuy", listBuy);
			body.put("orderDelivery", orderDelivery);
			
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("detailView: ", e);
			body.put("message", "주문내역 - 상세정보를 불러오는 중 오류가 발생했습니다.");
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
	public ResponseEntity<?> getMyReviewList(HttpSession session, @RequestParam(name = "pageNo", defaultValue = "1") int current_page) {
		Map<String, Object> body = new HashMap<>();
		Map<String, Object> map = new HashMap<>();
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			// 페이징
			int size = 10;
			int total_page = 0;
			int dataCount = 0;
			
			dataCount = reviewService.getMyReviewDataCount(info.getMemberId());
			total_page = paginateUtil.pageCount(dataCount, size);
			current_page = Math.min(current_page, total_page);
			
			// 리스트에 출력할 데이터를 가져오기
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			map.put("memberId", info.getMemberId());
			
			List<ProductReview> list = reviewService.getMyReviewList(map);
			
			// AJAX 용 페이징
			String paging = paginateUtil.pagingMethod(current_page, total_page, "reviewListPage");
			
			body.put("list", list);
			body.put("pageNo", current_page);
			body.put("replyCount", dataCount);
			body.put("total_page", total_page);
			body.put("paging", paging);
			
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("getMyReviewList: ", e);
			body.put("message", "나의 리뷰 정보를 불러오는 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}

	// 내 활동 - 리뷰 등록
	@PostMapping("/reviews/{orderDetailNum}")
	public ResponseEntity<?> insertReview(
			@PathVariable("orderDetailNum") long orderDetailNum,
			ProductReview dto,
			HttpSession session
		) {
		Map<String, Object> body = new HashMap<>();
		
		try {
			dto.setOrderDetailNum(orderDetailNum);
			
			reviewService.insertReview(dto, productReviewUploadPath);
			
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("insertReview: ", e);
			body.put("message", "리뷰 등록 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}
	
	// 반품 신청
	@PostMapping("/return/{orderDetailNum}")
	public ResponseEntity<?> insertReturn(
			@PathVariable("orderDetailNum") long orderDetailNum,
			Return dto,
			HttpSession session
			) {
		Map<String, Object> body = new HashMap<>();
		
		try {
			dto.setOrderDetailNum(orderDetailNum);
			
			returnService.insertReturn(dto, productReviewUploadPath);
			
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("insertReview: ", e);
			body.put("message", "반품 신청 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}
	
	// 환불 신청
	@PostMapping("/refund/{orderDetailNum}")
	public ResponseEntity<?> insertRefund(
			@PathVariable("orderDetailNum") long orderDetailNum,
			Refund dto,
			HttpSession session
			) {
		Map<String, Object> body = new HashMap<>();
		
		try {
			dto.setOrderDetailNum(orderDetailNum);
			
			refundService.insertRefund(dto, productReviewUploadPath);
			
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("insertReview: ", e);
			body.put("message", "환불 신청 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}
	
	// 내 활동 - 리뷰 수정
	@PutMapping("/reviews/{orderDetailNum}")
	public ResponseEntity<?> updateReview(
			@PathVariable("orderDetailNum") long orderDetailNum,
			ProductReview dto,
			HttpSession session
			) {
		Map<String, Object> body = new HashMap<>();
		
		try {
			dto.setOrderDetailNum(orderDetailNum);
			
			reviewService.updateReview(dto, productReviewUploadPath);
			
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("updateReview: ", e);
			body.put("message", "리뷰 수정 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}

	// 내 활동 - 리뷰 삭제
	@DeleteMapping("/reviews/{orderDetailNum}")
	public ResponseEntity<?> deleteReview(
			@PathVariable("orderDetailNum") long orderDetailNum,
			HttpSession session
			) {
		Map<String, Object> body = new HashMap<>();
		
		try {
			
			reviewService.deleteReview(orderDetailNum, productReviewUploadPath);
			
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("deleteReview: ", e);
			body.put("message", "리뷰 삭제 중 오류가 발생했습니다.");
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
			
			// 페이징
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
			String paging = paginateUtil.pagingMethod(current_page, total_page, "qnaListPage");
			
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
	
	// 구독중인 정보
	@GetMapping("/subInfo")
	public ResponseEntity<?> subInfo(@RequestParam Map<String, Object> paramMap,HttpSession session, Model model) throws Exception{
		Map<String, Object> body = new HashMap<>();
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
		    List<PackageOrder> list = mypageService.findMySubinfo(info.getMemberId());
			
		    PackageOrder dto = list.get(0);
		    
			body.put("dto",dto);
			body.put("list", list);
			
			return ResponseEntity.ok(body);
			
		} catch (Exception e) {
			log.error("detailView: ", e);
			body.put("message", "구독패키지정보 - 상세정보를 불러오는 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); 
		}
		
		
	}
	


}
