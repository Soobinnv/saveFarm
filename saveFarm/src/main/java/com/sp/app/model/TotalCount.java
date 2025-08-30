package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class TotalCount {
	private long totalWeightG; // 총 중량(g)

    private long totalAmount;  // 총 금액

    private int farmCount;     // 농가 수 (status = 3 조건)
}
