package com.sp.app.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.sp.app.model.Report;

public interface ReportService {
	public void insertReports(Report dto) throws SQLException;
	
	public int dataCount(Map<String, Object> map);
	public int dataGroupCount(Map<String, Object> map);
	
	public List<Report> listReports(Map<String, Object> map);
	public List<Report> listGroupReports(Map<String, Object> map);
	
	public Report findById(Long num);
	
	public int dataRelatedCount(Map<String, Object> map);
	public List<Report> listRelatedReports(Map<String, Object> map);

	public void updateReports(Report dto) throws SQLException;
	public void updateBlockPosts(Map<String, Object> ma) throws SQLException;
	public void deletePosts(Map<String, Object> map) throws SQLException;
	
	public Report findByPostsId(Map<String, Object> map);
}
