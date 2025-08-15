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
	
	// 상품 리뷰 이미지
	private long productReviewImageNum;
	private String productReviewImageFilename;
	private List<MultipartFile> reviewImages;
	
	// 상품 리뷰 댓글
	private long replyNum;
	private String replyRegDate;
	private String reply;
	private long reviewerMemberId;
	private String reviewerName;
	private String reviewerprofilePhoto;
	private int replyBlock;
}
