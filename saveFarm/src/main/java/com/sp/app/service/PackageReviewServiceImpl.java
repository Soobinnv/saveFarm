package com.sp.app.service;

import java.util.Objects;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.common.MyUtil;
import com.sp.app.common.StorageService;
import com.sp.app.exception.StorageException;
import com.sp.app.mapper.PackageReviewMapper;
import com.sp.app.model.packageReview;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class PackageReviewServiceImpl implements PackageReviewService{
	private final PackageReviewMapper mapper;
	private final StorageService storageService;
	private final MyUtil myUtil;

	@Override
	public void insertPackageReview(packageReview dto, String uploadPath) throws Exception {
		try {
			mapper.insertsubReview(dto);
			
			if(! dto.getSelectFile().isEmpty()) {
				insertPackageReviewFile(dto, uploadPath);
			}
			
			
		} catch (Exception e) {
			log.info("insertPackageReview : ",e);
			
			throw e;
		}
		
	}
	
	protected void insertPackageReviewFile(packageReview dto, String uploadPath) throws Exception {
		for(MultipartFile mf : dto.getSelectFile()) {
			try {
				String saveFilename = Objects.requireNonNull(storageService.uploadFileToServer(mf, uploadPath));
				
				dto.setImageFilename(saveFilename);

				mapper.insertsubImage(dto);
				
			} catch (NullPointerException e) {
			} catch (StorageException e) {
			} catch (Exception e) {
				throw e;
			}
		}
	}

}
