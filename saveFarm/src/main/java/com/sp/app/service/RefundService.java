package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.Refund;

public interface RefundService {
	public void insertRefund(Refund dto, String uploadPath) throws Exception;
	public void updateRefund(Refund dto, String uploadPath) throws Exception;
	public void deleteRefund(long refundNum, String uploadPath) throws Exception;
	public boolean deleteRefundImageFile(String uploadPath, String filename);
	
	public List<Refund> getRefundList(Map<String, Object> map);	
	public List<Refund> getMyRefundList(Map<String, Object> map);	
	public int getDataCount(Map<String, Object> map);
	public int getMyRefundDataCount(long memberId);
}
