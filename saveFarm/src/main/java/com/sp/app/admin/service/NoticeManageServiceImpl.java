package com.sp.app.admin.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.admin.mapper.NoticeManageMapper;
import com.sp.app.admin.model.CategoryInfo;
import com.sp.app.admin.model.NoticeManage;
import com.sp.app.common.StorageService;
import com.sp.app.exception.StorageException;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class NoticeManageServiceImpl implements NoticeManageService {
	private final NoticeManageMapper mapper;
	private final StorageService storageService;
	
	
	@Override
	public void insertNotice(NoticeManage dto, String uploadPath) throws Exception {
		try {
			if (dto.getClassify() == 0) { // 회원 공지사항
				dto.setCategoryNum(1); // 회원 카테고리 번호
			} else if (dto.getClassify() == 1) { // 농가 공지사항
				dto.setCategoryNum(2); // 농가 카테고리 번호
			} else {
				dto.setCategoryNum(dto.getClassify());
			}
			
			
			mapper.insertNotice(dto);
			
			if (! dto.getSelectFile().isEmpty()) {
				insertNoticeFile(dto, uploadPath);
			}
		} catch (Exception e) {
			log.info("insertNotice : ", e);
			throw e;
		}
	}

	@Override
	public void updateNotice(NoticeManage dto, String uploadPath) throws Exception {
		try {
			mapper.updateNotice(dto);

			if (! dto.getSelectFile().isEmpty()) {
				insertNoticeFile(dto, uploadPath);
			}

		} catch (Exception e) {
			log.info("updateNotice : ", e);
			
			throw e;
		}
	}

	@Override
	public void deleteNotice(long noticeNum, String uploadPath) throws Exception {
		try {
			List<NoticeManage> listFile = listNoticeFile(noticeNum);
			if (listFile != null) {
				for (NoticeManage dto : listFile) {
					deleteUploadFile(uploadPath, dto.getSaveFilename());
				}
			}
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("field", "noticeNum");
			map.put("fileNum", noticeNum);
			deleteNoticeFile(map);
			
			mapper.deleteNotice(noticeNum);
		} catch (Exception e) {
			log.info("deleteNotice : ", e);
			throw e;
		}
	}

	@Override
	public int noticeCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = mapper.noticeCount(map);
		} catch (Exception e) {
			log.info("noticeCount : ", e);
			throw e;
		}
		return result;
	}
	
	@Override
	public int noticeCount2(Map<String, Object> map) {
		int result = 0;
		try {
			result = mapper.noticeCount2(map);
		} catch (Exception e) {
			log.info("noticeCount : ", e);
			throw e;
		}
		return result;
	}
	
	
	@Override
	public List<NoticeManage> listNoticeTop(int classify) {
		List<NoticeManage> list = null;
		
		try {
			list = mapper.listNoticeTop(classify);
		} catch (Exception e) {
			log.info("listNoticeTop : ", e);
		}
		
		return list;
	}

	@Override
	public List<NoticeManage> listNotice(Map<String, Object> map) {
		List<NoticeManage> list = null;
		try {
			
			list = mapper.listNotice(map);
			
		} catch (Exception e) {
			log.info("listNoticeTop : ", e);
		}
		
		return list;
	}
	public List<NoticeManage> listNotice2(Map<String, Object> map) {
		List<NoticeManage> list = null;
		try {
			
			list = mapper.listNotice2(map);
			
		} catch (Exception e) {
			log.info("listNoticeTop : ", e);
		}
		
		return list;
	}

	@Override
	public void updateHitCount(long noticeNum) throws SQLException {
		try {
			mapper.updateHitCount(noticeNum);
			
		} catch (Exception e) {
			log.info("updateHitCount : ", e);
			throw e;
		}
		
	}

	@Override
	public NoticeManage findById(long noticeNum) {
		NoticeManage dto = null;
		
		try {
			dto = mapper.findById(noticeNum);
		} catch (Exception e) {
			log.info("findById : ", e);
		}
		
		return dto;
	}

	@Override
	public NoticeManage findByPrev(Map<String, Object> map) {
		NoticeManage dto = null;
		
		try {
			dto = mapper.findByPrev(map);
		} catch (Exception e) {
			log.info("findByPrev : ", e);
		}
		
		return dto;
	}

	@Override
	public NoticeManage findByNext(Map<String, Object> map) {
		NoticeManage dto = null;
		
		try {
			dto = mapper.findByNext(map);
		} catch (Exception e) {
			log.info("findByNext : ", e);
		}
		
		return dto;
	}

	@Override
	public List<NoticeManage> listNoticeFile(long noticeNum) {
		List<NoticeManage> list = null;
		
		try {
			list = mapper.listNoticeFile(noticeNum);
			
		} catch (Exception e) {
			log.info("listNoticeFile : ", e);
		}
		
		return list;
	}

	@Override
	public NoticeManage findByFileId(long fileNum) {
		NoticeManage dto = null;
		
		try {
			dto = mapper.findByFileId(fileNum);
			
		} catch (Exception e) {
			log.info("listNoticeFile : ", e);
		}
		
		return dto;
	}

	@Override
	public void insertNoticeFile(NoticeManage dto, String uploadPath) throws SQLException {
		for (MultipartFile mf : dto.getSelectFile()) {
			try {
				String saveFilename =  Objects.requireNonNull(storageService.uploadFileToServer(mf, uploadPath));

				String originalFilename = mf.getOriginalFilename();
				long fileSize = mf.getSize();

				dto.setOriginalFilename(originalFilename);
				dto.setSaveFilename(saveFilename);
				dto.setFileSize(fileSize);

				mapper.insertNoticeFile(dto);
			} catch (NullPointerException e) {
			} catch (StorageException e) {
			} catch (Exception e) {
				throw e;
			}
		}
	}

	@Override
	public void deleteNoticeFile(Map<String, Object> map) throws SQLException {
		try {
			mapper.deleteNoticeFile(map);
		} catch (Exception e) {
			log.info("deleteNoticeFile : ", e);
			
			throw e;
		}
		
	}

	@Override
	public boolean deleteUploadFile(String uploadPath, String filename) {
		return storageService.deleteFile(uploadPath, filename);
	}

	@Override
	public List<CategoryInfo> listAllCategories() {
		List<CategoryInfo> list = null;
		
		try {
			list = mapper.listAllCategories();
		} catch (Exception e) {
			log.info("listAllCategories : ", e);
		}
		return list;
	}

	@Override
	public int categoryCount() {
		int result = 0;
		try {
			result = mapper.categoryCount();
		} catch (Exception e) {
			log.info("noticeCount : ", e);
			throw e;
		}
		return result;
	}

	

	
}