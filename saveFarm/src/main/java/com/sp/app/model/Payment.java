package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Payment {
	private Long memberId;
	private String loginId;
	
	private long productNum;
	private String productName;
	private String mainImageFilename;
	private int price;
	private int discountRate;
	private int discountPrice;
	private int delivery;
	private int productClassification;

	private String orderNum;
	private String orderDate;
	private long orderDetailNum;
	private int payment;
	private int totalMoney;
	private int deliveryCharge;
	private int salePrice;
	private int qty;
	private String unit;
	private int productMoney;
	
	private String payMethod;
	private String cardName;
	private String cardNumber;
	private String applyNum;
	private String applyDate;
	
	private int orderState;
	private String orderStateInfo;
	private int detailState;
	private String detailStateInfo;
	private String stateMemo;
	private String stateDate;
	private String stateProduct;

	private String orderStateDate; // 상태변경일
	private String deliveryCompanyName; // 배송업체
	private String invoiceNumber; // 송장 번호
	private long afterDelivery; // 배송완료 후 날짜

	private int reviewWrite; // 리뷰 유무
}
