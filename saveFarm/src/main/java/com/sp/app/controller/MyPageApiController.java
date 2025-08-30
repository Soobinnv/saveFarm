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
import com.sp.app.mapper.MyPageMapper;
import com.sp.app.model.Member;
import com.sp.app.model.Order;
import com.sp.app.model.PackageOrder;
import com.sp.app.model.Payment;
import com.sp.app.model.ProductQna;
import com.sp.app.model.ProductReview;
import com.sp.app.model.Refund;
import com.sp.app.model.Return;
import com.sp.app.model.SessionInfo;
import com.sp.app.model.Wish;
import com.sp.app.model.packageReview;
import com.sp.app.service.MemberService;
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
	private final MemberService memberService;
	
	private String productReviewUploadPath;
	// 프로필 사진 업로드 경로 변수
	private String profilePhotoUploadPath; 
	
	
	
	@PostConstruct
	public void init() {
		productReviewUploadPath = this.storageService.getRealPath("/uploads/productReview");		
		this.profilePhotoUploadPath = this.storageService.getRealPath("/uploads/member/profile");
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
			String paging = paginateUtil.pagingMethod(current_page, total_page, "paymentListPage");
			
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
	
	// 주문내역 - 배송조회
	@GetMapping("/shipmentInfo")
	public ResponseEntity<?> shipmentInfo(@RequestParam Map<String, Object> paramMap, HttpSession session) {
	    Map<String, Object> body = new HashMap<>();
	    try {
	    	SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			paramMap.put("memberId", info.getMemberId());
	    	
	    	Payment dto = mypageService.findByOrderDetailDelivery(paramMap); 
	        
	    	body.put("dto", dto);
	    	return ResponseEntity.ok(body); // 200 OK
	    } catch (Exception e) {
	        log.error("shipmentInfo: ", e);
	        body.put("message", "배송정보를 불러오는 중 오류가 발생했습니다.");
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body);
	    }
	}

	// 구매 확정
	@PostMapping("confirmation")
	public ResponseEntity<?> confirmation(@RequestParam Map<String, Object> paramMap,
			HttpSession session) throws Exception {
		Map<String, Object> body = new HashMap<>();
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			paramMap.put("detailState", "1"); // 구매확정
			paramMap.put("stateMemo", "구매확정완료");
			paramMap.put("memberId", info.getMemberId());
			
			mypageService.updateOrderDetailState(paramMap);
			
			body.put("message", "구매확정이 성공적으로 처리되었습니다.");
			
			return ResponseEntity.ok(body); // 200 OK
		} catch (Exception e) {
			log.error("confirmation: ", e);
	        body.put("message", "구매확정을 처리하는 중 오류가 발생했습니다.");
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body);
		}
	}
	
	
	// 회원정보 수정
	@GetMapping("/memberInfo")
	public ResponseEntity<?> getMemberInfo(HttpSession session) {
		Map<String, Object> body = new HashMap<>();
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if (info == null) {
				body.put("message", "로그인이 필요합니다.");
				return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(body); // 401
			}

			// MemberService의 findById를 사용해 회원 정보를 조회합니다.
			Member dto = memberService.findById(info.getMemberId());
			
			if (dto == null) {
				body.put("message", "회원 정보를 찾을 수 없습니다.");
				return ResponseEntity.status(HttpStatus.NOT_FOUND).body(body); // 404
			}
			
			// API 응답 시 비밀번호는 제외하고 전달합니다.
			dto.setPassword(null);

			body.put("dto", dto);
			return ResponseEntity.ok(body); // 200 OK

		} catch (Exception e) {
			log.error("getMemberInfo: ", e);
			body.put("message", "회원 정보를 불러오는 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}

	@PostMapping("/memberInfo")
	public ResponseEntity<?> updateMemberInfo(Member dto, HttpSession session) {
		Map<String, Object> body = new HashMap<>();
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if (info == null) {
				body.put("message", "로그인이 필요합니다.");
				return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(body); // 401
			}
			
			// 중요: 현재 세션의 사용자 ID로 DTO를 설정하여 다른 사용자의 정보 수정을 방지합니다.
			dto.setMemberId(info.getMemberId());

			// MemberService의 updateMember 메서드를 호출합니다.
			memberService.updateMember(dto, profilePhotoUploadPath);

			// 세션 정보도 갱신합니다 (예: 이름이 변경된 경우).
			info.setName(dto.getPassword());

			body.put("message", "회원 정보가 성공적으로 수정되었습니다.");
			return ResponseEntity.ok(body); // 200 OK

		} catch (Exception e) {
			log.error("updateMemberInfo: ", e);
			body.put("message", "회원 정보 수정 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); // 500
		}
	}


	@PostMapping("/checkPwd")
	public ResponseEntity<?> checkPassword(@RequestParam String userPwd, HttpSession session) {
		Map<String, Object> body = new HashMap<>();
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if (info == null) {
				body.put("message", "로그인이 필요합니다.");
				return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(body);
			}

			Member member = memberService.findById(info.getMemberId());

			// ※ 중요: 이 코드는 비밀번호가 평문으로 저장된 경우에만 동작합니다.
			// 실제 서비스에서는 BCryptPasswordEncoder와 같은 암호화 라이브러리를 사용하여
			// passwordEncoder.matches(userPwd, member.getUserPwd()) 형태로 비교해야 합니다.
			boolean isPasswordCorrect = (member != null && userPwd.equals(member.getPassword()));

			body.put("success", isPasswordCorrect);
			if (!isPasswordCorrect) {
				body.put("message", "비밀번호가 일치하지 않습니다.");
			}
			
			return ResponseEntity.ok(body);

		} catch (Exception e) {
			log.error("checkPassword: ", e);
			body.put("message", "비밀번호 확인 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body);
		}
	}
	

	@PostMapping("/updatePwd")
	public ResponseEntity<?> updatePassword(@RequestParam String newPwd, HttpSession session) {
		Map<String, Object> body = new HashMap<>();
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if (info == null) {
				body.put("message", "로그인이 필요합니다.");
				return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(body);
			}
			
			Member dto = new Member();
			dto.setMemberId(info.getMemberId());
			dto.setPassword(newPwd); // ※ 중요: 서비스 단에서 암호화 후 업데이트해야 합니다.
			
			// 비밀번호만 변경하는 서비스가 없으므로 updateMember를 활용합니다.
			// 프로필 사진은 변경하지 않으므로 uploadPath는 null을 전달해도 무방합니다.
			memberService.updateMember(dto, null);
			
			body.put("message", "비밀번호가 성공적으로 변경되었습니다.");
			return ResponseEntity.ok(body);

		} catch (Exception e) {
			log.error("updatePassword: ", e);
			body.put("message", "비밀번호 변경 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body);
		}
	}
	
	
	// 내 활동 - 찜 데이터
	@GetMapping("/wishes")
	public ResponseEntity<?> getMyWishList(HttpSession session,  @RequestParam(name = "pageNo", defaultValue = "1") int current_page) {
		Map<String, Object> body = new HashMap<>();
		Map<String, Object> paramMap = new HashMap<>();
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			// 페이징
			int size = 10;
			int total_page = 0;
			int dataCount = 0;
			
			dataCount = wishService.getMyWishDataCount(info.getMemberId());
			total_page = paginateUtil.pageCount(dataCount, size);
			current_page = Math.min(current_page, total_page);
			
			// 리스트에 출력할 데이터를 가져오기
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;

			// AJAX 용 페이징
			String paging = paginateUtil.pagingMethod(current_page, total_page, "wishListPage");
			
			paramMap.put("offset", offset);
			paramMap.put("size", size);
			paramMap.put("memberId", info.getMemberId());
			
			List<Wish> list = wishService.getWishList(paramMap);
			
			body.put("list", list);
			body.put("pageNo", current_page);
			body.put("replyCount", dataCount);
			body.put("total_page", total_page);
			body.put("paging", paging);
			
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
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			dto.setMemberId(info.getMemberId());
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
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			dto.setMemberId(info.getMemberId());
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
	
	// 내 활동 - 나의 문의 데이터
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
	public ResponseEntity<?> subInfo(@RequestParam Map<String, Object> paramMap,HttpSession session) throws Exception{
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
	
	
	@GetMapping("/subReview")
	public ResponseEntity<?> mysubReview(@RequestParam Map<String, Object> paramMap,HttpSession session) throws Exception{
		Map<String, Object> body = new HashMap<>();
		
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			List<packageReview> list = mypageService.listmyReview(info.getMemberId());
			
			
			body.put("list", list);
			
			return ResponseEntity.ok(body);
		} catch (Exception e) {
			log.error("mysubReview: ", e);
			body.put("message", "나의 구독 리뷰 - 상세정보를 불러오는 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body); 
		}
	}


}
