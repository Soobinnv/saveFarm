package com.sp.app.admin.service;

import java.util.Map;

import com.sp.app.admin.model.Claim;

public interface AdminClaimService {
	public Map<String, Object> getClaimListAndPaging(Map<String, Object> paramMap);
	public Claim getClaimInfo(Map<String, Object> paramMap);
	public void updateClaimState(Claim dto) throws Exception;
	public void deleteClaim(long num, String type) throws Exception;
}
