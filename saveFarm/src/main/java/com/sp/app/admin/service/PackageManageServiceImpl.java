package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.admin.mapper.PackageManageMapper;
import com.sp.app.admin.model.PackageManage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class PackageManageServiceImpl implements PackageManageService{
	private final PackageManageMapper mapper;
	
	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = mapper.dataCount(map);
		} catch (Exception e) {
			log.info("dataCount : ", e);
		}
		
		return result;
	}

	@Override
	public List<PackageManage> packageList(Map<String, Object> map) {
		List<PackageManage> list = null;
		try {
			list = mapper.packageList(map);
			
			for(PackageManage dto : list) {
				dto.setProductList(productList(dto.getPackageNum()));
			}
			
		} catch (Exception e) {
			log.info("packageList : ", e);
		}
		return list;
	}
	
	@Override
	public List<PackageManage> modalpackageList(Map<String, Object> map) {
		List<PackageManage> list = null;
		try {
			list = mapper.modalpackageList(map);
			
		} catch (Exception e) {
			log.info("packageList : ", e);
		}
		return list;
	}

	@Override
	public List<PackageManage> productList(long packageNum) {
		List<PackageManage> list = null;
		try {
			list = mapper.productList(packageNum);
		} catch (Exception e) {
			log.info("productList : ", e);
		}		
				
		return list;
	}



}
