package com.sp.app.model;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

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
		// 상품 분류 코드
	private int varietyNum;
	private MultipartFile mainImageFile;
	
	// 상품 리뷰 수
	private int reviewCount;
	
	// 상품 상세
	private int stockQuantity;
	private String unit;
	private int unitPrice;
	private int discountRate;
	
	private int discountedPrice;
	
	// 긴급 구출 상품 정보
	private String endDate;
	private long supplyNum;
	private long farmNum;
	private String farmName;
	
	// 마감 임박 여부
	private int isUrgent;
	
	// 상품 이미지
	private long productImageNum;
	private String productImageFilename;
	private List<MultipartFile> productImages;
	
	// 회원의 찜 여부
	private int userWish;
}
