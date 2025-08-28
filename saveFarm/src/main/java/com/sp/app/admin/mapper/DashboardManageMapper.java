package com.sp.app.admin.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.DashboardManage;
import com.sp.app.admin.model.ReturnManage;
import com.sp.app.model.Refund;


@Mapper
public interface DashboardManageMapper {
	public List<Refund> dashboardRefundList();
	public List<ReturnManage> dashboardReturnList();
	
	public List<DashboardManage> dashboardChart();
	public List<DashboardManage> dashboardPackageChart();
}
