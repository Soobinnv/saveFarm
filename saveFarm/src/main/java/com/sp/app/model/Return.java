package com.sp.app.model;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Return {
	private long returnNum;
    private String reqDate;
    private String reason;
    // 반품 수량
    private int quantity;
    // status - 0: 신청, 1: 처리중, 2: 처리 완료, 3: 기각
    private int status;
    private String returnDate;
    private long orderDetailNum;
    
    // 반품 첨부 이미지
    private long returnImageNum;
    private String returnImageFilename;
    
    private List<MultipartFile> returnImages;  
    
    // 반품 신청 회원 ID
    private long memberId;
    private String email;
    
    // 반품 가능 수량
    private int claimableQuantity;
    
    // 추가 정보
    private long productNum;
	private String productName;
	// salePrice: 개당 판매가
	private int salePrice;
	private String orderNum;
	private int orderState;
	
	// 주문 수량
	private int orderQuantity;
}
