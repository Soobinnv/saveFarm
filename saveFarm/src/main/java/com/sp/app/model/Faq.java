package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Faq {
	private long faqNum;
	private String subject;
	private String content;
	private String regDate;
	private long memberId;

	private long categoryNum;
	private String categoryName;
	private int classify;

	private String name;
}
