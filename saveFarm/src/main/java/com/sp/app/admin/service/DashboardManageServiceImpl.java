package com.sp.app.admin.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.sp.app.admin.mapper.DashboardManageMapper;
import com.sp.app.model.Refund;
import com.sp.app.model.Return;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class DashboardManageServiceImpl implements DashboardManageService{
	private final DashboardManageMapper mapper; 
	
	@Override
	public List<Refund> dashboardRefundList() {
		List<Refund> list = null;
		
		try {
			list = mapper.dashboardRefundList();
		} catch (Exception e) {
			log.info("dashboardRefundList : ", e);
		}
		
		return list;
	}

	@Override
	public List<Return> dashboardReturnList() {
		List<Return> list = null;
		
		try {
			list = mapper.dashboardReturnList();
		} catch (Exception e) {
			log.info("dashboardReturnList : ", e);
		}
		
		return list;
	}

}
