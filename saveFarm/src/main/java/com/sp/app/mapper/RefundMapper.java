package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Refund;

@Mapper
public interface RefundMapper {
	public void insertRefund(Refund dto) throws SQLException;
	public void updateRefund(Refund dto) throws SQLException;
	public void deleteRefund(long orderDetailNum) throws SQLException;
	
	public List<Refund> getRefundList(Map<String, Object> map);	
	public List<Refund> getMyRefundList(Map<String, Object> map);
	public Refund getRefundInfo(Map<String, Object> map);
	public int getDataCount(Map<String, Object> map);
	public int getMyRefundDataCount(long memberId);
	public List<Integer> getMyProcessedRefundAmount(Map<String, Object> map);
}
