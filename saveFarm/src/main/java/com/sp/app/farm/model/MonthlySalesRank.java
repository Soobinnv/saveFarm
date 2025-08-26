package com.sp.app.farm.model;

import java.math.BigDecimal;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

//월별 판매순위 TOP10 (제품 기준 + 품종 표시)
@Getter
@Setter
@NoArgsConstructor
public class MonthlySalesRank {
    private Long productNum;
    private String productName;
    private Long varietyNum;     // supply 기준 대표 품종
    private String varietyName;
    private BigDecimal totalQty; // 월 판매량 합계
    private Integer rn;          // 순위(1~10)
    private String label;        // 'THIS' / 'LAST' (동시 비교 쿼리용)
}
