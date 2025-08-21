package com.sp.app.admin.model;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MemberManage {
	private Long memberId;
	private String loginId;
	private String password;
	private String snsProvider;
	private String snsId;
	private int userLevel;
	private int enabled;
	private String createdAt;
	private String updateAt;
	private String lastLogin;
	private int failureCnt;
	
	private String name;
	private String birth;
	private String profilePhoto;
	private String tel;
	private String zip;
	private String addr1;
	private String addr2;
	private String email;
	private int receiveEmail;
	private String ipAddr;
	
	private MultipartFile selectFile;
	
	private long num;
	private int statusCode;
	private String memo;
	private String regDate;
	private long registerId;
	
	private String loginRegister;
	private String registerName;
	
}
