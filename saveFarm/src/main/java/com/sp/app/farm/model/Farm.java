package com.sp.app.farm.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Farm {
	private Long farmNum;
	private String farmName;
	private String businessNumber;
	private String farmManager;
	private String farmTel;
	private String farmZip;
	private String farmAddress1;
	private String farmAddress2;
	private String farmRegDate;
	
	private String farmerName;
	private String farmerTel;
	private String farmerId;
	private String farmerPwd;
	
	private int status;
	private String farmAccount;
}
