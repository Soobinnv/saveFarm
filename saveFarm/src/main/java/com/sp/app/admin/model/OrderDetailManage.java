package com.sp.app.admin.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class OrderDetailManage {
	private long productNum;
	private String productName;
	private int optionCount;
	private int price;
    private int discountRate;
    private int delivery;
    private int cancelAmount;
    private Long member_id;
    private String login_id;
    private String name;
    
    private String orderNum;
    private long orderDetailNum;
	private String orderDate;
	private int usedSaved;
    private int payment;
    private int totalMoney;
    private int deliveryCharge;
    private int salePrice;
	private int qty;
	private int productMoney;
	private int savedMoney;
	private String orderStateDate;
	
	private long detailNum;
	private String optionValue;
	private Long detailNum2;
	private String optionValue2;
	
	private int orderState;
	private String orderStateInfo;
	private int detailState;
	private String detailStateInfo;
	private String stateMemo;
	private String stateDate;
	private String stateProduct;
	
	private String deliveryName; // 택배사
	private String invoiceNumber; // 송장번호
}
