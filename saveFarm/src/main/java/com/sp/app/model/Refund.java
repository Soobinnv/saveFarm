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
	private long refundNum;
	// 환불 수량
    private int refundAmount;
    private String reqDate;
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
    private String email;
    
    // 환불 가능 수량
    private int claimableQuantity;
    
    // 추가 정보
    private long productNum;
	private String productName;
	private int price;
	// salePrice: 할인된 가격
	private int salePrice;
	// quantity: 환불 수량
	private int quantity;
	private String orderNum;
	private int orderState;
	
	// 주문 수량
	private int orderQuantity;
	
	private String bankName;
	private String accountNumber;
	private String accountHolder;
}
