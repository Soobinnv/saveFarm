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
public class FarmManage {
	private long farmNum;
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
	
	
	private long supplyNum;
	private long supplyQuantity;
	private long unitQuantity;
	private long unitPrice; 
	private String harvestDate;
	private int state; 
	private String coment;
	private String supplyName;
	private String saleQuantity;
	private int rescuedApply; 
	private long productNum; 
	
	private int userLevel;
	
}
