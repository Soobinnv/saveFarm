package com.sp.app.admin.model;

import java.util.List;

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
public class OrderManage {
	private long productNum;
	private String productName;
	private String mainImageFilename;
	private int stockQuantity;
	private int discountRate;
	private int discountPrice;
	private int deliveryFee;
	
	
	private Long memberId;
	private String loginId;
	
	private String name;
	
	private String orderNum;
	private String orderDate;
	private int payment;
	private int deliveryCharge;
	private int totalMoney;
	private int orderState;
	private int discountMoney;
	private int cancelAmount;
	private String orderStateInfo;
	
	private long orderDetailNum;
	
	private int totalPayment;
	private int unitPrice;
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

	private String orderStateDate; // 상태변경일자
	private long deliveryCompanyNum; // 택배사 번호
	private String deliveryCompanyName; // 택배사
	private String invoiceNumber; // 송장번호
	
	private int totalOrderCount; // 주문 상품수
	private int totalQty; // 상품 주문 개수
	private int detailCancelCount; // 취소건수(판매취소, 주문취소완료, 반품접수, 반품완료)
	private int cancelRequestCount; // 배송전 주문 취소요청수, 반품요청수
	private int exchangeRequestCount; // 배송후 교환 요청수
	
	
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
