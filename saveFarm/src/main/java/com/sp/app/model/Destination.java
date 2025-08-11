package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

//배송지
@Getter
@Setter
@NoArgsConstructor
public class Destination {
	private long destinationNum;
	private Long memberId;
	private String addressName;
	private String recipientName;
	private int defaultDest;
	private String tel;
	private String tel1;
	private String tel2;
	private String tel3;
	private String zip;
	private String addr1;
	private String addr2;
	private String pickup;
	private String accessInfo;
	private String passcode;
	private int accessSave;
}
