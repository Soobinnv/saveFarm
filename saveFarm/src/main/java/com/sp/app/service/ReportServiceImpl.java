package com.sp.app.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.ReportMapper;
import com.sp.app.model.Report;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ReportServiceImpl implements ReportService{
	private final ReportMapper mapper;
	@Override
	public void insertReports(Report dto) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int dataGroupCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Report> listReports(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Report> listGroupReports(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Report findById(Long num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int dataRelatedCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Report> listRelatedReports(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateReports(Report dto) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateBlockPosts(Map<String, Object> ma) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deletePosts(Map<String, Object> map) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Report findByPostsId(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

}
