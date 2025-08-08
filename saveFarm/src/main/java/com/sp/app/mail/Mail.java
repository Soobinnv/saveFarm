package com.sp.app.mail;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Mail {
	private String receiverEmail;  // 받는 사람  이메일
	private String senderEmail; // 보내는 사람  이메일
	private String senderName; // 보내는 사람  이름
	private String subject; // 메일 제목
	private String content; // 메일 내용

	// 스프링에서 파일 받기
	private List<MultipartFile> selectFile; // <input type="file" name="selectFile"
	private List<String> savePathname = new ArrayList<>();
}
