package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Member;

@Mapper
public interface MemberMapper {
	public Member loginMember(Map<String, Object> map);
	public Member loginSnsMember(Map<String, Object> map);
	public void updateLastLogin(Long member_id) throws SQLException;
	
	public Long memberSeq();
	public void insertMember1(Member dto) throws SQLException;
	public void insertMember2(Member dto) throws SQLException;
	public void insertMember12(Member dto) throws SQLException;
	public void insertSnsMember(Member dto) throws SQLException;
	
	public void updateMemberEnabled(Map<String, Object> map) throws SQLException;
	public void updateMemberLevel(Map<String, Object> map) throws SQLException;
	public void updateMember1(Member dto) throws SQLException;
	public void updateMember2(Member dto) throws SQLException;
	public void deleteProfilePhoto(Map<String, Object> map) throws SQLException;

	public Member findById(Long memberId);
	public Member findByLoginId(String loginId);
	
	public void deleteMember1(Map<String, Object> map) throws SQLException;
	public void deleteMember2(Map<String, Object> map) throws SQLException;
	
	public List<Member> listFindMember(Map<String, Object> map);
}
