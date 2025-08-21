package com.sp.app.admin.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.CategoryInfo;
import com.sp.app.admin.model.NoticeManage;

public interface NoticeManageService {
	public void insertNotice(NoticeManage dto, String uploadPath) throws Exception;
	public void updateNotice(NoticeManage dto, String uploadPath) throws Exception;
	public void deleteNotice(long noticeNum, String uploadPath) throws Exception;
	
	public int noticeCount(Map<String, Object> map);
	public List<NoticeManage> listNoticeTop(int classify);
	public List<NoticeManage> listNotice(Map<String, Object> map);
	
	public void updateHitCount(long noticeNum) throws SQLException;
	public NoticeManage findById(long noticeNum);
	public NoticeManage findByPrev(Map<String, Object> map);
	public NoticeManage findByNext(Map<String, Object> map);

	public List<NoticeManage> listNoticeFile(long noticeNum);
	public NoticeManage findByFileId(long fileNum);
	
	public void insertNoticeFile(NoticeManage dto, String uploadPath) throws SQLException;
	public void deleteNoticeFile(Map<String, Object> map) throws SQLException;
	public boolean deleteUploadFile(String uploadPath, String filename);
	
	public List<CategoryInfo> listAllCategories();
	public int categoryCount();
}
