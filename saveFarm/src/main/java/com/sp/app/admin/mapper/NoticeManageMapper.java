package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.CategoryInfo;
import com.sp.app.admin.model.NoticeManage;

@Mapper
public interface NoticeManageMapper {
	public long noticeSeq();
	
	public void insertNotice(NoticeManage dto) throws SQLException;
	public void updateNotice(NoticeManage dto) throws SQLException;
	public void deleteNotice(long noticeNum) throws SQLException;
	
	public int noticeCount(Map<String, Object> map);
	public List<NoticeManage> listNoticeTop(int classify);
	public List<NoticeManage> listNotice(Map<String, Object> map);
	
	public NoticeManage findById(Long memberId);
	public void updateHitCount(long noticeNum) throws SQLException;
	public NoticeManage findByPrev(Map<String, Object> map);
	public NoticeManage findByNext(Map<String, Object> map);

	public void insertNoticeFile(NoticeManage dto) throws SQLException;
	public List<NoticeManage> listNoticeFile(long noticeNum);
	public NoticeManage findByFileId(long fileNum);
	public void deleteNoticeFile(Map<String, Object> map) throws SQLException;
	
	public List<CategoryInfo> listAllCategories();
	
	public int categoryCount();
	
}
