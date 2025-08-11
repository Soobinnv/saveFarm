package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.Destination;
import com.sp.app.model.Order;

public interface MyShoppingService {
	public void insertCart(Order dto) throws Exception;
	public List<Order> listCart(Long memberId);
	public void deleteCart(Map<String, Object> map) throws Exception;

	public void insertDestination(Destination dto) throws Exception;
	public int destinationCount(Long memberId);
	public List<Destination> listDestination(Long memberId);
	public void updateDestination(Destination dto) throws Exception;
	public void updateDefaultDestination(Map<String, Object> map) throws Exception;
	public void deleteDestination(Map<String, Object> map) throws Exception;
	public Destination defaultDelivery(Long memberId);
}
