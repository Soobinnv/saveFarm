package com.sp.app.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.common.StorageService;
import com.sp.app.exception.StorageException;
import com.sp.app.mapper.HomeBobMapper;
import com.sp.app.model.HomeBob;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class HomeBobServiceImpl implements HomeBobService {
	private final HomeBobMapper mapper;
	private final StorageService storageService;
	
	@Override
	public void insertHomeBob(HomeBob dto, String uploadPath) throws Exception {
		try {
			long seq = mapper.homeBobSeq();
			dto.setNum(seq);

			mapper.insertHomeBob(dto);

			// 파일 업로드
			if (! dto.getSelectFile().isEmpty()) {
				insertHomeBobFile(dto, uploadPath);
			}

		} catch (Exception e) {
			log.info("insertHomeBob : ", e);
			
			throw e;
		}

		
	}

	@Override
	public void updateHomeBob(HomeBob dto, String uploadPath) throws Exception {
		try {
			mapper.updateHomeBob(dto);

			if (! dto.getSelectFile().isEmpty()) {
				insertHomeBobFile(dto, uploadPath);
			}

		} catch (Exception e) {
			log.info("updateHomeBob : ", e);
			
			throw e;
		}
		
	}

	@Override
	public void deleteHomeBob(long num, String uploadPath) throws Exception {
		try {
			// 파일 지우기
			List<HomeBob> listFile = listHomeBobFile(num);
			if (listFile != null) {
				for (HomeBob dto : listFile) {
					deleteUploadFile(uploadPath, dto.getImageFilename());
				}
			}

			// 파일 테이블 내용 지우기
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("field", "num");
			map.put("num", num);
			deleteHomeBobFile(map);

			mapper.deleteHomeBob(num);
		} catch (Exception e) {
			log.info("deleteHomeBob : ", e);
			
			throw e;
		}
		
	}

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
	public List<HomeBob> listHomeBob(Map<String, Object> map) {
		List<HomeBob> list = null;

		try {
			list = mapper.listHomeBob(map);
		} catch (Exception e) {
			log.info("listHomeBob : ", e);
		}
		return list;
	}

	@Override
	public HomeBob findById(long num) {
		HomeBob dto = null;

		try {
			dto = mapper.findById(num);
		} catch (Exception e) {
			log.info("findById : ", e);
		}

		return dto;
	}

	@Override
	public HomeBob findByPrev(Map<String, Object> map) {
		HomeBob dto = null;

		try {
			dto = mapper.findByPrev(map);
		} catch (Exception e) {
			log.info("findByPrev : ", e);
		}

		return dto;
	}

	@Override
	public HomeBob findByNext(Map<String, Object> map) {
		HomeBob dto = null;

		try {
			dto = mapper.findByNext(map);
		} catch (Exception e) {
			log.info("findByNext : ", e);
		}

		return dto;
	}

	@Override
	public HomeBob findByFileId(long fileNum) {
		HomeBob dto = null;

		try {
			dto = mapper.findByFileId(fileNum);
		} catch (Exception e) {
			log.info("findByFileId : ", e);
		}

		return dto;
	}

	@Override
	public List<HomeBob> listHomeBobFile(long num) {
		List<HomeBob> listFile = null;

		try {
			listFile = mapper.listHomeBobFile(num);
		} catch (Exception e) {
			log.info("listHomeBobFile : ", e);
		}

		return listFile;
	}

	@Override
	public void deleteHomeBobFile(Map<String, Object> map) throws Exception {
		try {
			mapper.deleteHomeBobFile(map);
		} catch (Exception e) {
			log.info("deleteHomeBobFile : ", e);
			
			throw e;
		}
		
	}

	@Override
	public boolean deleteUploadFile(String uploadPath, String filename) {
		return storageService.deleteFile(uploadPath, filename);
	}
	
	protected void insertHomeBobFile(HomeBob dto, String uploadPath) throws Exception {
		for (MultipartFile mf : dto.getSelectFile()) {
			try {
				String saveFilename = Objects.requireNonNull(storageService.uploadFileToServer(mf, uploadPath));
				long fileSize = mf.getSize();
				
				dto.setImageFilename(saveFilename);
				dto.setFileSize(fileSize);

				mapper.insertHomeBobFile(dto);
			} catch (NullPointerException e) {
			} catch (StorageException e) {
			} catch (Exception e) {
				throw e;
			}
		}
	}

}
