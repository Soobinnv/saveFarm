package com.sp.app.admin.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Refund;
import com.sp.app.model.Return;


@Mapper
public interface DashboardManageMapper {
	public List<Refund> dashboardRefundList();
	public List<Return> dashboardReturnList();
	
	public List<Return> dashboardChart();
}
