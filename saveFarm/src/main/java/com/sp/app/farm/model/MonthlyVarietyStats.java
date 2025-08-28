package com.sp.app.farm.model;

import java.math.BigDecimal;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

//월별 인기순위 TOP10 (리뷰 평균 별점)
@Getter
@Setter
@NoArgsConstructor
public class MonthlyVarietyStats {
	private String monthKey;         // "YYYY-MM"
	private Long   varietyNum;       // 품목번호(없으면 null)
	private String varietyName;      // 품목명(없으면 null)

	// 지표(쿼리에 따라 채워지는 것만 값이 들어옴)
	private Long       totalWeightG;   // 판매 중량(g)
	private BigDecimal totalAmount;    // 판매 금액
	private BigDecimal star;        // 평균 별점
	private BigDecimal avgStar;        // 평균 별점
	private Integer    reviewCount;    // 리뷰 수

	// 랭킹(쿼리에서 rn 별칭을 rank로 맞추면 공용 사용 가능)
	private Integer rank;
}