package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.packageReview;

public interface PackageReviewService {
	public void insertPackageReview(packageReview dto, String uploadPath) throws Exception;
	public int countReview();
	public List<packageReview> listReview(Map<String, Object>map);
}
