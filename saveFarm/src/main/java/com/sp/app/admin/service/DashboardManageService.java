package com.sp.app.admin.service;

import java.util.List;

import com.sp.app.admin.model.DashboardManage;
import com.sp.app.admin.model.ReturnManage;
import com.sp.app.model.Refund;

public interface DashboardManageService {
	public List<Refund> dashboardRefundList();
	public List<ReturnManage> dashboardReturnList();
	
	public List<DashboardManage> dashboardChart();
	public List<DashboardManage> dashboardPackageChart();
}
