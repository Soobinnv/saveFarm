package com.sp.app.admin.model;

import java.util.Date;
import java.util.List;

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
public class NoticeManage {
	
	private long noticeNum;
    private int notice;
    private long memberId;
    private String subject;
    private String content;
    private int hitCount;
    private Date regDate;
    private long updateId;
    private Date updateDate; 
    private int showNotice;

    private int categoryNum;
    private String categoryName;
    private int classify;
	
    private int fileCount;
    
	private String updateName;
	private String loginId;
	private String loginUpdate;
	private String name;
	
	private long fileNum;
	private String saveFilename;
	private String originalFilename;
	private long fileSize;
	
	private List<MultipartFile> selectFile; // <input type="file" name="selectFile"
	private List<NoticeManage> listFile;
	private long gap;
	
	private int categoryCount;

}
