package com.sp.app.model;

import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class PackageOrder {
	private long packageNum;
	private String packageName;
	private int price;
	private String content;
	private int isExtend;
	
	private long itemNum;
	private String subNum;
	private String payMethod;
	
	private long productNum;
	private int itemPrice;
	private int count;
	
	private String productName;
	private String MAINIMAGEFILENAME;
	
	private List<String> productNames;
	private List<String> mainImageFileNames;
	
	
	private List<Long> productNums;
	private List<Integer> itemPrices;
	private List<Integer> counts;
	
	private long subPackageNum;
	private long packagePrice;
	
	private int subMonth;
	private String payDate;
	private int totalPay;
	private long memberId;
	
	private Long homePackageNum;
	private Long saladPackageNum;
	
	private int qty;
	
	private long desNum;
	private String receiver;
	private String tel;
	private String zip;
	private String addr;
}
