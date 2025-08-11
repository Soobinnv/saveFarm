package com.sp.app.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.sp.app.model.Wish;

public interface WishService {
	public void insertWish(Map<String, Object> map) throws SQLException;
	public List<Wish> getWishList(long memberId);
	public Wish findByWishId(Map<String, Object> map);
	public void deleteWish(Map<String, Object> map) throws Exception;
}
