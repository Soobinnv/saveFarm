package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Reports {
	private long num;				// report 번호
	private long reprotedBy;		// 신고자 번호
	private long targetNum;			// 신고된 게시물 번호
	private String targetTable; 	// 신고된 게이물명
	private int targetType;			// 신고된 게시물 타입(댓글신고, 제품신고 등등)
	private String targetContent;	// 신고된 게시물 내용
	private String reason; 			// 사유
	private String reportDate; 		// 신고일
	private String reportIp;		// 신고자 Ip
	private int status; 			// 처리상태
	private long handledBy; 		// 처리자
	private String handlingNote; 	// 처리내용
	private String handledDate; 	// 처리일
}
