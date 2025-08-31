package com.sp.app.admin.model;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.sp.app.model.Refund;
import com.sp.app.model.Return;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Claim {
	// 전체 클레임 정보 (환불, 반품)
	
	private String listType;
	private long num;
	// 등록 날짜
	private String reqDate;
	private String detail1;
	private String detail2;
	private String processDate;
	private long orderDetailNum;
	// status - 0: 신청, 1: 처리중, 2: 처리 완료, 3: 기각
    private int status;
    // 신청 회원 ID
    private long returnMemberId;
    private String email;
	
    // 환불 첨부 이미지
    private long refundImageNum;
    private String refundImageFilename;
    
    private List<MultipartFile> refundImages;

    // 반품 첨부 이미지
    private long returnImageNum;
    private String returnImageFilename;
    
    private List<MultipartFile> returnImages; 
    
    // 반품 정보
    private Return returnObj;
    // 환불 정보
    private Refund refundObj;
    
    // 주문 수량
 	private int orderQuantity;
 	// 환불 금액
 	private int refundAmount;
}
