package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Order;

@Mapper
public interface OrderMapper {
	public String findByMaxOrderNumber();
	
	public void insertOrder(Order dto) throws SQLException;
	public void insertPayDetail(Order dto) throws SQLException;
	public void insertOrderDetail(Order dto) throws SQLException; 
	public void insertOrderDelivery(Order dto) throws SQLException;
	
	public void updateOrderState(Order dto) throws SQLException;
	public void updateProductStockDec(Order dto) throws SQLException;
	
	public List<Order> listOrderProduct(List<Map<String, Long>> list);
	public List<Order> listOptionDetail(List<Long> detailNums);
	public Order findByOrderDetail(long orderDetailNum);
	public Order findByProduct(long productNum);
	public Order findByOptionDetail(long detailNum);
}
