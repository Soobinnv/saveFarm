package com.sp.app.admin.service;

import java.util.List;

import com.sp.app.model.Refund;
import com.sp.app.model.Return;

public interface DashboardManageService {
	public List<Refund> dashboardRefundList();
	public List<Return> dashboardReturnList();
}
