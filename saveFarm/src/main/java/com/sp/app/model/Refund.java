package com.sp.app.model;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Refund {
	// 환불 정보
	private long refundNum;
    private int refundAmount;
    private String refundDate;
    private String refundMethod;
    private long orderDetailNum;
    // status - 0: 신청, 1: 처리중, 2: 처리 완료, 3: 기각
    private int status;
    
    // 환불 첨부 이미지
    private long refundImageNum;
    private String refundImageFilename;
    
    private List<MultipartFile> refundImages;
    
    // 반품 신청 회원 ID
    private long memberId;
}
