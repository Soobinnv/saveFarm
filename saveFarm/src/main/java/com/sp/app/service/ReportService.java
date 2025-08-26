package com.sp.app.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.sp.app.model.Reports;

public interface ReportService {
	public void insertReports(Reports dto) throws SQLException;
	
	public int dataCount(Map<String, Object> map);
	public int dataGroupCount(Map<String, Object> map);
	
	public List<Reports> listReports(Map<String, Object> map);
	public List<Reports> listGroupReports(Map<String, Object> map);
	
	public Reports findById(Long num);
	
	public int dataRelatedCount(Map<String, Object> map);
	public List<Reports> listRelatedReports(Map<String, Object> map);

	public void updateReports(Reports dto) throws SQLException;
	public void updateBlockPosts(Map<String, Object> ma) throws SQLException;
	public void deletePosts(Map<String, Object> map) throws SQLException;
	
	public Reports findByPostsId(Map<String, Object> map);
}
