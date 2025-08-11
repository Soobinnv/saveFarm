package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Destination;
import com.sp.app.model.Order;

@Mapper
public interface MyShoppingMapper {
	// 장바구니
	public void insertCart(Order dto) throws SQLException;
	public void updateCart(Order dto) throws SQLException;
	public Order findByCartId(Map<String, Object> map);
	public List<Order> listCart(Long member_id);
	public void deleteCart(Map<String, Object> map) throws SQLException;
	public void deleteCartExpiration() throws SQLException;

	// 배송지
	public void insertDestination(Destination dto) throws SQLException;
	public void deleteOldestDestination(Long member_id) throws SQLException;
	public int destinationCount(Long member_id);
	public List<Destination> listDestination(Long member_id);
	public void updateDestination(Destination dto) throws SQLException;
	public void updateDefaultDestination(Map<String, Object> map) throws SQLException;
	public void deleteDestination(Map<String, Object> map) throws SQLException;
	public Destination defaultDelivery(Long member_id);

}
