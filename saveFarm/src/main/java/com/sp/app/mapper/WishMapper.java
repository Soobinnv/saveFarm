package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Wish;

@Mapper
public interface WishMapper {
	public void insertWish(Map<String, Object> map) throws SQLException;
	public List<Wish> getWishList(Map<String, Object> map);
	public Wish findByWishId(Map<String, Object> map);
	public void deleteWish(Map<String, Object> map) throws Exception;
	
	public int getMyWishDataCount(long memberId);
}
