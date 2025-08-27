package com.sp.app.farm.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.admin.model.NoticeManage;
import com.sp.app.farm.mapper.NoticeMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class NoticeServiceImpl implements NoticeService {
	private final NoticeMapper mapper;

	@Override
	public int noticeCount(Map<String, Object> map) {
		int count = 0;
		try {
			if(mapper.noticeCount(map) != 0 ) {
				count = mapper.noticeCount(map);
			}
		} catch (Exception e) {
			log.info("noticeCount : ", e);
		}
		return count;
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
			log.info("listNotice : ", e);
		}
		return list;
	}

	@Override
	public void updateHitCount(long noticeNum) throws Exception {
		try {
			mapper.updateHitCount(noticeNum);
		} catch (Exception e) {
			log.info("updateHitCount : ", e);
			throw e;
		}
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
	public List<NoticeManage> listFarmCategories() {
		List<NoticeManage> list = null;
		try {
			list = mapper.listFarmCategories();
		} catch (Exception e) {
			log.info("listFarmCategories : ", e);
		}
		return list;
	}

	@Override
	public NoticeManage findByFileId(long fileNum) {
		NoticeManage dto = null;
		try {
			dto = mapper.findByFileId(fileNum);
		} catch (Exception e) {
			log.info("findByFileId : ", e);
		}
		return dto;
	}

	@Override
	public NoticeManage findByNoticeNum(Map<String, Object> map) {
		NoticeManage dto = null;
		try {
			dto = mapper.findByNoticeNum(map);
		} catch (Exception e) {
			log.info("findByNoticeNum : ", e);
		}
		return dto;
	}

	

}
