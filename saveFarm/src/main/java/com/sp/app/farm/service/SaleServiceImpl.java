package com.sp.app.farm.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.farm.mapper.FarmSaleMapper;
import com.sp.app.farm.model.MonthlyVarietyStats;
import com.sp.app.farm.model.MyFarmSale;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class SaleServiceImpl implements SaleService {

	private final FarmSaleMapper mapper;

	@Override
	public BigDecimal myFarmTotalEarning(Long farmNum) {
		BigDecimal count = BigDecimal.ZERO;
		
		try {
			if(mapper.myFarmTotalEarning(farmNum) != BigDecimal.ZERO) {			
				count = mapper.myFarmTotalEarning(farmNum);
			}
		} catch (Exception e) {
			log.info("myFarmTotalEarning : ", e);
		}
		
		return count;
	}

	@Override
	public List<MyFarmSale> myFarmListByVariety(Map<String, Object> map) {
		List<MyFarmSale> list = null;
		
		try {
			list = mapper.myFarmListByVariety(map);
		} catch (Exception e) {
			log.info("myFarmTotalEarning : ", e);
		}
		
		return list;
	}

	@Override
	public int myFarmListByVarietyCount(Map<String, Object> map) {
		int count = 0;
		
		try {
			if(mapper.myFarmListByVarietyCount(map) != 0) {
				count = mapper.myFarmListByVarietyCount(map);
			}
		} catch (Exception e) {
			log.info("myFarmListByVarietyCount : ", e);
		}
		
		return count;
	}

	@Override
	public List<MonthlyVarietyStats> listMonthlyVarietyWeight(Map<String, Object> map) {
		List<MonthlyVarietyStats> list = null;
		
		try {
			list = mapper.listMonthlyVarietyWeight(map);
		} catch (Exception e) {
			log.info("listMonthlyVarietyWeight : ", e);
		}
		
		return list;
	}

	@Override
	public List<MonthlyVarietyStats> listMonthlyVarietyAmount(Map<String, Object> map) {
		List<MonthlyVarietyStats> list = null;
		
		try {
			list = mapper.listMonthlyVarietyAmount(map);
		} catch (Exception e) {
			log.info("listMonthlyVarietyAmount : ", e);
		}
		
		return list;
	}

	@Override
	public List<MonthlyVarietyStats> listMonthlyVarietyWeightAndAmount(Map<String, Object> map) {
		List<MonthlyVarietyStats> list = null;
		
		try {
			list = mapper.listMonthlyVarietyWeightAndAmount(map);
		} catch (Exception e) {
			log.info("listMonthlyVarietyWeightAndAmount : ", e);
		}
		
		return list;
	}

	@Override
	public List<MonthlyVarietyStats> listMonthlyAvgStarByVariety(Map<String, Object> map) {
		List<MonthlyVarietyStats> list = null;
		
		try {
			list = mapper.listMonthlyAvgStarByVariety(map);
		} catch (Exception e) {
			log.info("listMonthlyAvgStarByVariety : ", e);
		}
		
		return list;
	}

	@Override
	public List<MonthlyVarietyStats> getMonthlyAvgStarByVariety(Map<String, Object> map) {
		List<MonthlyVarietyStats> list = null;
		
		try {
			list = mapper.getMonthlyAvgStarByVariety(map);
		} catch (Exception e) {
			log.info("getMonthlyAvgStarByVariety : ", e);
		}
		
		return list;
	}

	@Override
	public List<MonthlyVarietyStats> listMonthlyAvgStarOverall(Map<String, Object> map) {
		List<MonthlyVarietyStats> list = null;
		
		try {
			list = mapper.listMonthlyAvgStarOverall(map);
		} catch (Exception e) {
			log.info("listMonthlyAvgStarOverall : ", e);
		}
		
		return list;
	}

}


