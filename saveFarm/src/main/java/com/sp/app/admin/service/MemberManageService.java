package com.sp.app.admin.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.MemberManage;

public interface MemberManageService {
	public int dataCount(Map<String, Object> map);
	public List<MemberManage> listMember(Map<String, Object> map);
	
	public MemberManage findById(Long memberId);
	
	public void updateMember(Map<String, Object> map) throws Exception;
	public void updateMemberLevel(Map<String, Object> map) throws SQLException;
	public void updateMemberEnabled(Map<String, Object> map) throws SQLException;
	public void deleteMember(Long memberId) throws SQLException;
	
	public void insertMemberStatus(MemberManage dto) throws SQLException;
	public List<MemberManage> listMemberStatus(Long memberId);
	public MemberManage findByStatus(Long memberId);
	
	public void updateFailureCountReset(Long memberId) throws SQLException;
	
}
