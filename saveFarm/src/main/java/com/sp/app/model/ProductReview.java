package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ProductReview {
	// 상품 리뷰
	private long orderDetailNum;
	private String review;
	private int star;
	private String reviewDate;
	private int reviewBlock;
	private long productNum;
	
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
	private int replyBlock;
}
