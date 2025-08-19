package com.sp.app.model;

import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Order {
	private long productNum;
	private String productName;
	private String mainImageFilename;
	private int stockQuantity;
	private int discountRate;
	private int discountPrice;
	private int deliveryFee;
	private int deliveryCharge;
	
	private Long memberId;
	private String loginId;
	
	private String orderNum;
	private long orderDetailNum;
	private String orderDate;
	private int payment;
	private int totalPayment;
	private int unitPrice;
	private int totalMoney;
	private int salePrice;
	private int qty;
	private String unit;
	private int productMoney;

	private int totalStock;	

	private List<Long> productNums;
	private List<Integer> buyQtys;
	private List<Integer> productMoneys;
	private List<Integer> unitPrices;
	private List<Integer> salePrices;
	private List<String> units;
	
	private Long cartNum;

	// 배송지 정보
	private String recipientName;
	private String tel;
	private String zip;
	private String addr1;
	private String addr2;
	private String pickup;
	private String accessInfo;
	private String passcode;
	private String requestMemo;

	// 결제 내역 정보
	private String impUid;
	private String payMethod;
	private String cardName;
	private String cardNumber;
	private String applyNum;
	private String applyDate;	
}
