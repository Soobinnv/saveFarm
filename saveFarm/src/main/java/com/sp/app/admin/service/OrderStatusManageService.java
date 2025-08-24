package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.OrderDetailManage;
import com.sp.app.admin.model.OrderManage;

public interface OrderStatusManageService {
	public int orderCount(Map<String, Object> map);
	public List<OrderManage> listOrder(Map<String, Object> map);
	public OrderManage findByOrderId(String orderNum);
	public List<OrderDetailManage> listOrderDetails(String orderNum);
	
	public int detailCount(Map<String, Object> map);
	public List<OrderDetailManage> listDetails(Map<String, Object> map);
	public OrderDetailManage findByDetailId(Long orderDetailNum);
	
	public void updateOrder(String mode, Map<String, Object> map) throws Exception;
	public void updateOrderDetailState(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> listDeliveryCompany();
	public List<Map<String, Object>> listDetailStateInfo(long orderDetailNum);
	
	public OrderManage findByDeliveryId(String orderNum);
	public Map<String, Object> findByPayDetail(String orderNum);
}
