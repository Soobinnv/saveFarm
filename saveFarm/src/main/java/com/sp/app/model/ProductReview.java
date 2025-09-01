package com.sp.app.model;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

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
	private String reviewTitle;
	
	private String productName;
	private String mainImageFilename;
	private String unit;
	
	private long reviewerMemberId;
	private String reviewerName;
	private String reviewerProfilePhoto;
	
	// 상품 리뷰 추천 수
	private int helpfulCount;
	
	// 상품 리뷰 이미지
	private long productReviewImageNum;
	private String productReviewImageFilename;
	private List<MultipartFile> reviewImages;
	
	// 상품 리뷰 댓글
	private long replyNum;
	private String replyRegDate;
	private String reply;
	private long replyAuthorMemberId;
	private String replyAuthorName;
	private String replyAuthorProfilePhoto;
	private int replyBlock;
	
	// 현재 사용자의 리뷰 추천 여부
	private int userLike; // 0: false, 1: true

	// 주문 날짜
	private String orderDate;
}
