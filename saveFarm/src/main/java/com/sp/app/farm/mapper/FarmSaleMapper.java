package com.sp.app.farm.mapper;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.farm.model.MonthlyRatingRank;
import com.sp.app.farm.model.MonthlySalesRank;
import com.sp.app.farm.model.MyFarmSale;

@Mapper
public interface FarmSaleMapper {
	 /**
     * 상단 총 벌은 금액
     * - 조건: supply.state=5 AND approvedDate IS NOT NULL AND farmNum=?
     * - 반환: SUM(supplyQuantity / unitQuantity * unitPrice)
     */
    public BigDecimal myFarmTotalEarning(Long farmNum);

    /**
     * 품종별 리스트 (페이징)
     * - 조건: 위와 동일 + (kwd 있을 경우 varietyName LIKE)
     * - 정렬: totalEarning DESC, totalQty DESC
     */
    public List<MyFarmSale> myFarmListByVariety(Map<String, Object> map);
    
    
    public int myFarmListByVarietyCount(Map<String, Object> map);

    // ===========================
    // 월별 TOP10 (최근 12개월 시리즈)
    // ===========================

    /**
     * 최근 12개월 월별 판매순위 TOP10 시리즈
     * - 기준월(m_offset)을 포함해 기준월-11개월 ~ 기준월까지 12개월을 라벨(YYYY-MM)로 반환
     * List<Integer> paidStates // null 가능
     */
    public List<MonthlySalesRank> topMonthlySalesSeries(Map<String, Object> map);

    /**
     * 최근 12개월 월별 인기순위 TOP10 시리즈
     * - 기준월(m_offset)을 포함해 기준월-11개월 ~ 기준월까지 12개월을 라벨(YYYY-MM)로 반환
     * null 가능
     */
    public List<MonthlyRatingRank> topMonthlyRatingSeries(Map<String, Object> map);
    
    // 월별 판매순위, 인기순위
    public List<MonthlySalesRank>  topMonthlySales(Map<String,Object> map);
    public List<MonthlyRatingRank> topMonthlyRating(Map<String,Object> map);

    // 이번달, 지난달 판매수누이, 인기순위
    public List<MonthlySalesRank>  topMonthlySalesThisVsLast(Map<String,Object> map);
    public List<MonthlyRatingRank> topMonthlyRatingThisVsLast(Map<String,Object> map);
}
