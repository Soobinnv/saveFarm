package com.sp.app.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.admin.mapper.ClaimManageMapper;
import com.sp.app.common.PaginateUtil;
import com.sp.app.mapper.RefundMapper;
import com.sp.app.mapper.ReturnMapper;
import com.sp.app.service.RefundService;
import com.sp.app.service.ReturnService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class AdminClaimServiceImpl implements AdminClaimService {
	
	private final RefundMapper refundMapper;
	private final ReturnMapper returnMapper;
	private final ClaimManageMapper claimManageMapper;
	private final ReturnService returnService;
	private final RefundService refundService;
	private final PaginateUtil paginateUtil;
	
	@Override
	public Map<String, Object> getClaimListAndPaging(Map<String, Object> paramMap) {
		Map<String, Object> ListAndPaging = new HashMap<>();
		List<?> list = null;
		
		try {
			String type = (String) paramMap.get("type");
			int size = (int) paramMap.get("size");
			int total_page = (int) paramMap.get("total_page");
			int dataCount = (int) paramMap.get("dataCount");
			int current_page = (int) paramMap.get("current_page");
			
			switch (type) {
				case "return": {
					dataCount = returnService.getDataCount(paramMap);
					total_page = paginateUtil.pageCount(dataCount, size);
					
					int offset = (current_page - 1) * size;
					if(offset < 0) offset = 0;
					
					paramMap.put("offset", offset);
					
					list = returnMapper.getReturnList(paramMap);
					break;
				}
				case "refund": {
					dataCount = refundService.getDataCount(paramMap);
					total_page = paginateUtil.pageCount(dataCount, size);
					
					int offset = (current_page - 1) * size;
					if(offset < 0) offset = 0;
					
					paramMap.put("offset", offset);
					
					list = refundMapper.getRefundList(paramMap);
					break;
				}
				// 통합 리스트
				case null: {
					dataCount = claimManageMapper.getDataCount(paramMap);
					total_page = paginateUtil.pageCount(dataCount, size);
					
					int offset = (current_page - 1) * size;
					if(offset < 0) offset = 0;
					
					paramMap.put("offset", offset);
					
					list = claimManageMapper.getClaimList(paramMap);
					break;
				}
				default:
					return null;
				}
			
			ListAndPaging.put("list", list);
			
			ListAndPaging.put("dataCount", dataCount);
			ListAndPaging.put("size", size);
			ListAndPaging.put("total_page", total_page);
			ListAndPaging.put("current_page", current_page);
			
		} catch (Exception e) {
			log.info("getClaimListAndPaging: ", e);
			throw e;
		}
		
		return ListAndPaging;
	}

}
