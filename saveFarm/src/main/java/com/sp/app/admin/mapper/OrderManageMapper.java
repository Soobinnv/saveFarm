package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.OrderDetailManage;
import com.sp.app.admin.model.OrderManage;

@Mapper
public interface OrderManageMapper {
	public int orderCount(Map<String, Object> map);
	public List<OrderManage> listOrder(Map<String, Object> map);
	public OrderManage findByOrderId(String orderNum);
	public List<OrderDetailManage> listOrderDetails(String orderNum);
	
	public int detailCount(Map<String, Object> map);
	public List<OrderDetailManage> listDetails(Map<String, Object> map);
	public OrderDetailManage findByDetailId(Long orderDetailNum);
	
	public void updateProductStockInc(Map<String, Object> map) throws SQLException;
	
	public void updateOrderState(Map<String, Object> map) throws SQLException;
	public int findByTotalCancelAmount(String orderNum);
	public int totalOrderCount(String orderNum);

	public void updateCancelAmount(Map<String, Object> map) throws SQLException;
	public void updateOrderInvoiceNumber(Map<String, Object> map) throws SQLException;
	public void updateOrderDetailState(Map<String, Object> map) throws SQLException;
	
	public List<Map<String, Object>> listDeliveryCompany();
	public void insertDetailStateInfo(Map<String, Object> map) throws SQLException;
	public List<Map<String, Object>> listDetailStateInfo(long orderDetailNum);
	
	public List<Long> listExpiredPeriodOrder();
	public void updateAutoPurchaseconfirmation(Map<String, Object> map) throws SQLException;
	public void updateAutoPurchaseconfirmation2() throws SQLException;
	
	public OrderManage findByDeliveryId(String orderNum);
	public Map<String, Object> findByPayDetail(String orderNum);
}
