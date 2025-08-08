package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.Member;

public interface MemberService {
	public Member loginMember(Map<String, Object> map);
	public Member loginSnsMember(Map<String, Object> map);
	
	public void insertMember(Member dto, String uploadPath) throws Exception;
	public void insertSnsMember(Member dto) throws Exception;
	
	public void updateLastLogin(Long member_id) throws Exception;
	public void updateMember(Member dto, String uploadPath) throws Exception;
	
	public Member findById(Long member_id);
	public Member findById(String login_id);
	
	public void deleteMember(Map<String, Object> map, String uploadPath) throws Exception;
	public void deleteProfilePhoto(Map<String, Object> map, String uploadPath) throws Exception;
	
	public void generatePwd(Member dto) throws Exception;
	
	public List<Member> listFindMember(Map<String, Object> map);	
}
