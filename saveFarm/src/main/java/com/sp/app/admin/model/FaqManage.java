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
public class FaqManage {
	// FAQ , categoryFAQ 컬럼
	private long faqNum;
	private String subject;
	private String content;
	private String regDate;
	private long memberId;
	
	private long categoryNum;
	private String categoryName;
	private int classify;

	private String name;
	
	private int dataCount;   // COUNT(*) AS dataCount 와 매핑
    private int memberCount; // COUNT(DECODE(classify, 1, 1)) AS memberCount 와 매핑
    private int farmCount;
}
