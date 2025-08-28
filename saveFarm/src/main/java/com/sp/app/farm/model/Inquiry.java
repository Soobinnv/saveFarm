package com.sp.app.farm.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Inquiry {
	private long inquiryNum;
	private String subject;
	private String content;
	private String regDate;
	private String answer;
	private String answerDate;
	private int processResult;
	private Long memberId;
	private Long farmNum;
	private Long answerId;
}
