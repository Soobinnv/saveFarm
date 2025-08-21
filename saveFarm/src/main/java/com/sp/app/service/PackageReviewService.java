package com.sp.app.service;

import com.sp.app.model.packageReview;

public interface PackageReviewService {
	public void insertPackageReview(packageReview dto, String uploadPath) throws Exception;
}
