package com.sp.app.model;

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
public class SessionInfo {
	private long memberId;
	private String loginId;
	private String name;
	private String email;
	private int userLevel;
	private String login_type; // local, kakao, naver, google
	private String avatar; // profile photo
	private int cartSize;
}
