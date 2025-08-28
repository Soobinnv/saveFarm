package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Notice {
	private long noticeNum;
	private String name;
	private int notice;
	private String subject;
	private String content;
	private int hitCount;
	private String regDate;
	private int showNotice;
	private String updateDate;
	
	private int categoryNum;
	private long fileNum;
	private String originalFilename;
	private String saveFilename;
	private long fileSize;
	private int fileCount;
	
	private long gap;
}
