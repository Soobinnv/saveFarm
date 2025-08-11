package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Product {
	// 상품 정보
	private long productNum;
	private String productName;
	private String productDesc;
	private int deliveryFee;
	private String mainImageFilename;
	private int productClassification;
	
	// 상품 상세
	private int stockQuantity;
	private String unit;
	private int unitPrice;
	private int discountRate;
	
	private int discountedPrice;
	
	// 긴급 구출 상품 정보
	private String endDate;
	private long supplyNum;
	
	// 상품 이미지
	private long productImageNum;
	private String productImageFilename;
	
	// 상품 리뷰
	private long orderDetailNum;
	private String review;
	private int star;
	private String reviewDate;
	
	// 상품 리뷰 이미지
	private long productReviewImageNum;
	private String productReviewImageFilename;
	
	// 상품 리뷰 댓글
	private long replyNum;
	private String regDate;
	private String reply;
	private long memberId;
	private String name;
	private String profilePhoto;
	
	// 회원의 찜 여부
	private int userWish;
}
