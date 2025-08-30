package com.sp.app.admin.service;

import java.util.Map;

import com.sp.app.admin.model.Claim;

public interface AdminClaimService {
	public Map<String, Object> getClaimListAndPaging(Map<String, Object> paramMap);
	public Claim getClaimInfo(Map<String, Object> paramMap);
}
