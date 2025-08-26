package com.sp.app.farm.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.farm.mapper.FarmSaleMapper;
import com.sp.app.farm.model.MonthlyRatingRank;
import com.sp.app.farm.model.MonthlySalesRank;
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
	public List<MonthlySalesRank> topMonthlySalesSeries(Map<String, Object> map) {
		List<MonthlySalesRank> list = null;
		
		try {
			list = mapper.topMonthlySalesSeries(map);
		} catch (Exception e) {
			log.info("topMonthlySalesSeries : ", e);
		}
		
		return list;
	}

	@Override
	public List<MonthlyRatingRank> topMonthlyRatingSeries(Map<String, Object> map) {
		List<MonthlyRatingRank> list = null;
		
		try {
			list = mapper.topMonthlyRatingSeries(map);
		} catch (Exception e) {
			log.info("topMonthlyRatingSeries : ", e);
		}
		
		return list;
	}

	@Override
	public List<MonthlySalesRank> topMonthlySales(Map<String, Object> map) {
		List<MonthlySalesRank> list = null;
		
		try {
			list = mapper.topMonthlySales(map);
		} catch (Exception e) {
			log.info("topMonthlySales : ", e);
		}
		
		return list;
	}

	@Override
	public List<MonthlyRatingRank> topMonthlyRating(Map<String, Object> map) {
		List<MonthlyRatingRank> list = null;
		
		try {
			list = mapper.topMonthlyRating(map);
		} catch (Exception e) {
			log.info("topMonthlyRating : ", e);
		}
		
		return list;
	}

	@Override
	public List<MonthlySalesRank> topMonthlySalesThisVsLast(Map<String, Object> map) {
		List<MonthlySalesRank> list = null;
		
		try {
			list = mapper.topMonthlySalesThisVsLast(map);
		} catch (Exception e) {
			log.info("topMonthlySalesThisVsLast : ", e);
		}
		
		return list;
	}

	@Override
	public List<MonthlyRatingRank> topMonthlyRatingThisVsLast(Map<String, Object> map) {
		List<MonthlyRatingRank> list = null;
		
		try {
			list = mapper.topMonthlyRatingThisVsLast(map);
		} catch (Exception e) {
			log.info("topMonthlyRatingThisVsLast : ", e);
		}
		
		return list;
	}
	
	

}


