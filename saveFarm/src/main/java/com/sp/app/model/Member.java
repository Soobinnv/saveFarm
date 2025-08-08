package com.sp.app.model;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Member {
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
	private String failureCnt;
	
	private String name;
	private String birth;
	private String profilePhoto;
	private String tel;
	private String zip;
	private String addr1;
	private String addr2;
	private String email;
	private int receive_email;
	private String ipAddr;
	
	private MultipartFile selectFile;
}
