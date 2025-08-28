package com.sp.app.farm.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import com.sp.app.farm.model.MonthlyVarietyStats;
import com.sp.app.farm.model.MyFarmSale;

public interface SaleService {
	public BigDecimal myFarmTotalEarning(Long farmNum);

    public List<MyFarmSale> myFarmListByVariety(Map<String, Object> map);
    public int myFarmListByVarietyCount(Map<String, Object> map);
    
    public List<MonthlyVarietyStats> listMonthlyVarietyWeight(Map<String, Object> map);
    public List<MonthlyVarietyStats> listMonthlyVarietyAmount(Map<String, Object> map);
    public List<MonthlyVarietyStats> listMonthlyVarietyWeightAndAmount(Map<String, Object> map);
    public List<MonthlyVarietyStats> listMonthlyAvgStarByVariety(Map<String, Object> map);
    public List<MonthlyVarietyStats> getMonthlyAvgStarByVariety(Map<String, Object> map);
    public List<MonthlyVarietyStats> listMonthlyAvgStarOverall(Map<String, Object> map);
}
