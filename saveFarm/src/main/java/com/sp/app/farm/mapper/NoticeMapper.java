package com.sp.app.farm.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.NoticeManage;


@Mapper
public interface NoticeMapper {
	
	public int noticeCount(Map<String, Object> map);

	public List<NoticeManage> listNoticeTop(int classify);
	
	public List<NoticeManage> listNotice(Map<String, Object> map);
	
	public List<NoticeManage> listFarmCategories();
	
	public void updateHitCount(long noticeNum) throws SQLException;
	
	public NoticeManage findByNoticeNum(Map<String, Object> map);
	
	public NoticeManage findByPrev(Map<String, Object> map);
	public NoticeManage findByNext(Map<String, Object> map);

	public List<NoticeManage> listNoticeFile(long noticeNum);

	public NoticeManage findByFileId(long fileNum);
}

