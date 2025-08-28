package com.sp.app.farm.model;

import java.math.BigDecimal;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

//월별 인기순위 TOP10 (리뷰 평균 별점)
@Getter
@Setter
@NoArgsConstructor
public class MonthlyRatingRank {
    private Long productNum;
    private String productName;
    private Long varietyNum;
    private String varietyName;
    private BigDecimal avgStar;  // 평균 별점(소수)
    private Integer reviewCnt;   // 리뷰 개수
    private Integer rn;          // 순위(1~10)
    private String label;        // 'THIS' / 'LAST'}
}