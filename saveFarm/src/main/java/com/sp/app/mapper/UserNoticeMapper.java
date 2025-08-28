package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Notice;

@Mapper
public interface UserNoticeMapper {
	public int dataCount(Map<String, Object> map);
	public List<Notice> listNoticeTop();
	public List<Notice> listNotice(Map<String, Object> map);
	
	public Notice findById(long num);
	public void updateHitCount(long num) throws SQLException;
	public Notice findByPrev(Map<String, Object> map);
	public Notice findByNext(Map<String, Object> map);

	public List<Notice> listNoticeFile(long num);
	public Notice findByFileId(long fileNum);
}
