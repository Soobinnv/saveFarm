package com.sp.app.farm.mapper;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.farm.model.MonthlyVarietyStats;
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

    public List<MonthlyVarietyStats> listMonthlyVarietyWeight(Map<String, Object> map);
    public List<MonthlyVarietyStats> listMonthlyVarietyAmount(Map<String, Object> map);
    public List<MonthlyVarietyStats> listMonthlyVarietyWeightAndAmount(Map<String, Object> map);
    public List<MonthlyVarietyStats> listMonthlyAvgStarByVariety(Map<String, Object> map);
    public List<MonthlyVarietyStats> getMonthlyAvgStarByVariety(Map<String, Object> map);
    public List<MonthlyVarietyStats> listMonthlyAvgStarOverall(Map<String, Object> map);
}
