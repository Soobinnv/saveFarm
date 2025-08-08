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
	
}
