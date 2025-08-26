package com.sp.app.model;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class packageReview {
	private int count;
	private String subNum;
	private Long memberId;
	private int star;
	private String subject;
	private String content;
	private String regDate;
	private String memberName;
	
	private long imageNum;
	private String imageFilename;
	private List<MultipartFile> selectFile;
	private int subMonth;
	
	private String name;
	
	private String[] listFilename;
}
