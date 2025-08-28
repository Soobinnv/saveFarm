package com.sp.app.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.UserNoticeMapper;
import com.sp.app.model.Notice;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class UserNoticeServiceImpl implements UserNoticeService{
	private final UserNoticeMapper mapper;

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
	public List<Notice> listNoticeTop() {
		List<Notice> list = null;

		try {
			list = mapper.listNoticeTop();
		} catch (Exception e) {
			log.info("listNoticeTop : ", e);
		}

		return list;
	}

	@Override
	public List<Notice> listNotice(Map<String, Object> map) {
		List<Notice> list = null;

		try {
			list = mapper.listNotice(map);
			
			// 오늘날짜와 게시글 입력 날짜차이 계산
			/*
			long gap;
			Date curDate = new Date();
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			for (Notice dto : list) {
				Date date = formatter.parse(dto.getReg_date());
				// gap = (curDate.getTime() - date.getTime()) / (1000*60*60*24); // 일자
				gap = (curDate.getTime() - date.getTime()) / (1000 * 60 * 60); // 시간
				dto.setGap(gap);

				dto.setUpdate_date(dto.getReg_date().substring(0, 10));
			}
			*/
			
			long gap;
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			LocalDateTime today = LocalDateTime.now();
			for (Notice dto : list) {
				LocalDateTime dateTime = LocalDateTime.parse(dto.getRegDate(), formatter);
				gap = dateTime.until(today, ChronoUnit.HOURS);
				dto.setGap(gap);
				
				dto.setUpdateDate(dto.getRegDate().substring(0, 10));
			}
			
		} catch (Exception e) {
			log.info("listNotice : ", e);
		}

		return list;
	}

	@Override
	public Notice findById(long num) {
		Notice dto = null;

		try {
			dto = mapper.findById(num);
		} catch (Exception e) {
			log.info("findById : ", e);
		}

		return dto;
	}

	@Override
	public void updateHitCount(long num) throws Exception {
		try {
			mapper.updateHitCount(num);
		} catch (Exception e) {
			log.info("updateHitCount : ", e);
			
			throw e;
		}
	}

	@Override
	public Notice findByPrev(Map<String, Object> map) {
		Notice dto = null;

		try {
			dto = mapper.findByPrev(map);
		} catch (Exception e) {
			log.info("findByPrev : ", e);
		}

		return dto;
	}

	@Override
	public Notice findByNext(Map<String, Object> map) {
		Notice dto = null;

		try {
			dto = mapper.findByNext(map);
		} catch (Exception e) {
			log.info("findByNext : ", e);
		}

		return dto;
	}

	@Override
	public List<Notice> listNoticeFile(long num) {
		List<Notice> listFile = null;

		try {
			listFile = mapper.listNoticeFile(num);
		} catch (Exception e) {
			log.info("listNoticeFile : ", e);
		}

		return listFile;
	}

	@Override
	public Notice findByFileId(long fileNum) {
		Notice dto = null;

		try {
			dto = mapper.findByFileId(fileNum);
		} catch (Exception e) {
			log.info("findByFileId : ", e);
		}

		return dto;
	}
	
}
