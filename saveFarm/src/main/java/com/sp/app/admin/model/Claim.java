package com.sp.app.admin.model;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

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
	// 환불 정보
	private long refundNum;
    private int refundAmount;
    private String refundDate;
    private String refundMethod;
    private long orderDetailNum;
    
    // 환불 첨부 이미지
    private long refundImageNum;
    private String refundImageFilename;
    
    private List<MultipartFile> refundImages;
    
	// 반품 정보
	private long returnNum;
    private String reqDate;
    private String reason;
    private int quantity;
    private String returnDate;
    
    // 반품 첨부 이미지
    private long returnImageNum;
    private String returnImageFilename;
    
    private List<MultipartFile> returnImages; 
    
    // 반품 신청 회원 ID
    private long refundMemberId;
    
    // 반품 신청 회원 ID
    private long returnMemberId;
    
    // status - 0: 신청, 1: 처리중, 2: 처리 완료, 3: 기각
    private int status;
}
