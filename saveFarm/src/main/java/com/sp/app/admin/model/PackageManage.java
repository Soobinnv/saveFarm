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
public class PackageManage {
	
	// 구독패키지 subPackage
	private long subPackageNum; // 구독패키지번호
	private long packagePrice;	// 구독패키지가격
	
	// 패키지 package
	private long homePackageNum;	// 집밥패키지번호
	private long saladPackageNum;	// 셀러드패키지번호
	private long packageNum;		// 패키지번호
	private String packageName;
	private int price;
	private String packageContent;
	
	// 구독 패키지 품목 packageItem
	private int qty;
	// private long productNum; // 상품상세 ProductDetail 와 JOIN
	
	// 구독현황 subStatus
	private String subNum; // 구독현황번호
	private int subMonth;
	private String payDate;
	private String payMethod; // 결제수
	private int totalPay;
	private int isExtend; // 구독연장여부
	
	// 구독리뷰 subReview
	private String subject;
	private String content;
	private String regDate;
	private int star;
	
	// 구독리뷰사진 subImage
	private long imageNum;	// 이미지번호
	private String imageFilename; // 이미지파일명

	// 구독상품 subItem
	private long itemNum;
	private int itemPrice;
	private int count;
	
	// 정기구독 배송지 subDestination
	private long desNum;
	private String receiver;
	private String tel;
	private String zip;
	private String addr;
	
	
	// 상품 Product
	private long productNum;
	private String productName;
	private List<PackageManage> productList;
	
	// 상품상세 ProductDetail;
	private String unit;
	
	// 회원1 member1
	private long memberId;
	
	// 회원2 member2
}
