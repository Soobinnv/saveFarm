package com.sp.app.farm.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Supply {
	private Long supplyNum;
	private int supplyQuantity;
	private int unitQuantity;
	private int unitPrice;
	private String harvestDate;
	private String approvedDate;
	private int state;
	private int rescuedApply;
	private String coment;

	private Long farmNum;
	private String farmerId;
	private Long productNum;
	private Long varietyNum;
	
    private String farmName;
    private String productName;
    private String varietyName;
}
