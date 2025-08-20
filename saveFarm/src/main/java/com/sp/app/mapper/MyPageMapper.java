package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Order;
import com.sp.app.model.Payment;

@Mapper
public interface MyPageMapper {
	public int countPayment(Map<String, Object> map);
	public List<Payment> listPayment(Map<String, Object> map);
	public List<Payment> listPaymentDelivery(Map<String, Object> map);
	public List<Payment> listPurchase(Map<String, Object> map);
	public List<Payment> listPurchaseDelivery(Map<String, Object> map);

	public Payment findByOrderDetail(Map<String, Object> map);
	public Payment findByOrderDetailDelivery(Map<String, Object> map);
	public Order findByOrderDelivery(Map<String, Object> map);
	public void updateOrderState(Map<String, Object> map) throws SQLException;
	public void updateOrderHistory(long orderDetailNum) throws SQLException;

	// 주문상세 상태 등록
	public void insertDetailStateInfo(Map<String, Object> map) throws SQLException;

}
