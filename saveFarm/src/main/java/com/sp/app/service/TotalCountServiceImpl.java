package com.sp.app.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.TotalCountMapper;
import com.sp.app.model.TotalCount;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class TotalCountServiceImpl implements TotalCountService{
	private final TotalCountMapper mapper;

	@Override
	public TotalCount getSiteTotalsAllTime() {
		TotalCount dto = null;
		
		try {
			dto = mapper.getSiteTotalsAllTime();
		} catch (Exception e) {
			log.info("getSiteTotalsAllTime : ", e);
		}
		
		return dto;
	}

	@Override
	public TotalCount countFarm() {
		TotalCount dto = null;
		
		try {
			dto = mapper.countFarm();
		} catch (Exception e) {
			log.info("countFarm : ", e);
		}
		
		return dto;
	}
	
	
}
