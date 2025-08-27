package com.sp.app.farm.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Inquiry {
	private long num;
	private Long member_id;
	private String name;
	private String category;
	private String subject;
	private String question;
	private String reg_date;
	private String answerName;
	private String answer;
	private String answer_date;
}
