package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ProductQna {
	private long qnaNum;
	private int secret;
	private String title;
	private String question;
	private String answer;
	private int block;
	private long memberId;
	private long answerId;
	private long productNum;
	private String qnaDate;
}
