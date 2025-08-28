package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.Notice;


public interface UserNoticeService {
	public int dataCount(Map<String, Object> map);
	public List<Notice> listNoticeTop();
	public List<Notice> listNotice(Map<String, Object> map);
	
	public void updateHitCount(long num) throws Exception;
	public Notice findById(long num);
	public Notice findByPrev(Map<String, Object> map);
	public Notice findByNext(Map<String, Object> map);
	
	public List<Notice> listNoticeFile(long num);
	public Notice findByFileId(long fileNum);
}
