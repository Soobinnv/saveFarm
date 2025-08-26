package com.sp.app.farm.model;

import java.math.BigDecimal;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class MyFarmSale {
	private Long varietyNum;       	// 품종 번호
    private String varietyName;    	// 품종 이름
    private BigDecimal  totalQty;   		// 총 납품 양 (supplyQuantity 합)
    private BigDecimal  totalVarietyEarning; 		// 총 벌은 금액
    private Integer rn;            	// 순번 (ROW_NUMBER)
}
