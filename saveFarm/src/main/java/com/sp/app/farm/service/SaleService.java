package com.sp.app.farm.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import com.sp.app.farm.model.MonthlyRatingRank;
import com.sp.app.farm.model.MonthlySalesRank;
import com.sp.app.farm.model.MyFarmSale;

public interface SaleService {
	public BigDecimal myFarmTotalEarning(Long farmNum);

    public List<MyFarmSale> myFarmListByVariety(Map<String, Object> map);
    public int myFarmListByVarietyCount(Map<String, Object> map);
    
    public List<MonthlySalesRank> topMonthlySalesSeries(Map<String, Object> map);
    public List<MonthlyRatingRank> topMonthlyRatingSeries(Map<String, Object> map);
    
    public List<MonthlySalesRank>  topMonthlySales(Map<String,Object> map);
    public List<MonthlyRatingRank> topMonthlyRating(Map<String,Object> map);

    public List<MonthlySalesRank>  topMonthlySalesThisVsLast(Map<String,Object> map);
    public List<MonthlyRatingRank> topMonthlyRatingThisVsLast(Map<String,Object> map);
}
