package com.sp.app.admin.model;

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
public class InquiryManage {
	private long inquiryNum;
	private String subject;
	private String content;
	private String regDate;
	
	private long answerId;
	
	private String loginId;
	private String loginAnswer;
	private String answerName;
	private String answer;
	private String answerDate;
	
	private long farmNum;
	private long memberId;
	private int processResult;
	
	private long categoryNum;
    private String categoryName;
    private int classify; // -- 0 : 회원, 1: 농가, 2: 농가 가이드라인
    
    private String Name;
    private String farmerId;
    private String farmName;
}
