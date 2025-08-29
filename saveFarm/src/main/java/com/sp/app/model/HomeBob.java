package com.sp.app.model;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class HomeBob {
	private long num;
	private Long memberId;
	private String name;
	private String subject;
	private String content;
	private String regDate;
	private List<MultipartFile> selectFile;
	
	private long fileNum;
	private long fileSize;
	private String imageFilename;
}
