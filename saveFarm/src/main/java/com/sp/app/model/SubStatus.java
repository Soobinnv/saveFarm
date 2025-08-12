package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class SubStatus {
	private long subNum;
	private int subMonth;
	private String payDate;
	private int totalPay;
	private long memberId;
}
