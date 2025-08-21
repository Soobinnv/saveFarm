package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.MemberManage;

@Mapper
public interface MemberManageMapper {
	public int dataCount(Map<String, Object> map);
	public List<MemberManage> listMember(Map<String, Object> map);
	
	public MemberManage findById(Long member_id);
	
	public void updateMember1(Map<String, Object> map) throws SQLException;
	public void updateMember2(Map<String, Object> map) throws SQLException;
	public void updateMemberLevel(Map<String, Object> map) throws SQLException;
	public void updateMemberEnabled(Map<String, Object> map) throws SQLException;
	public void deleteMember(Long memberId) throws SQLException;
	
	public void insertMemberStatus(MemberManage dto) throws SQLException;
	public List<MemberManage> listMemberStatus(Long memberId);
	public MemberManage findByStatus(Long memberId);
	
	public void updateFailureCountReset(Long memberId) throws SQLException;
}
