package com.sp.app.farm.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.NoticeManage;

public interface NoticeService {
	public int noticeCount(Map<String, Object> map);

	public List<NoticeManage> listNoticeTop(int classify);
	
	public List<NoticeManage> listNotice(Map<String, Object> map);
	
	public List<NoticeManage> listFarmCategories();
	
	public void updateHitCount(long noticeNum) throws Exception;
	
	public NoticeManage findByNoticeNum(Map<String, Object> map);
	
	public NoticeManage findByPrev(Map<String, Object> map);
	public NoticeManage findByNext(Map<String, Object> map);

	public List<NoticeManage> listNoticeFile(long noticeNum);
	
	public NoticeManage findByFileId(long fileNum);
}
