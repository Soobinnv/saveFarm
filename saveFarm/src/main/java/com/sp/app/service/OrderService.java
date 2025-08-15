package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.Order;

public interface OrderService {
	public String productOrderNumber();
	public void insertOrder(Order dto) throws Exception;
	
	public List<Order> listOrderProduct(List<Map<String, Long>> list);
	public List<Order> listOptionDetail(List<Long> detailNums);
	public Order findByOrderDetail(long orderDetailNum);
	public Order findByProduct(long productNum);
	public Order findByOptionDetail(long detailNum);
	
	public void updateOrderState(Order dto);
}
