package com.sp.app.service;

import java.util.Map;

import com.sp.app.model.TotalCount;

public interface TotalCountService {
	public TotalCount getSiteTotalsAllTime();

	public TotalCount countFarm();
}
