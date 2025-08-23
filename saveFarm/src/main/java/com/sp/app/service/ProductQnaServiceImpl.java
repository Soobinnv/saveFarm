package com.sp.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import com.sp.app.common.MyUtil;
import com.sp.app.mapper.ProductQnaMapper;
import com.sp.app.model.ProductQna;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ProductQnaServiceImpl implements ProductQnaService {

    private final MyUtil myUtil;
	private final ProductQnaMapper mapper;
	
	@Override
	public void insertQna(ProductQna dto) throws Exception {
		try {
			mapper.insertQna(dto);
			
		} catch (Exception e) {
			log.info("insertQna : ", e);
			
			throw e;
		}
	}

	@Override
	public void updateQna(ProductQna dto) throws Exception {
		try {
			mapper.updateQna(dto);
			
		} catch (Exception e) {
			log.info("updateQna : ", e);
			
			throw e;
		}
		
	}

	@Override
	public void deleteQna(long qnaNum) throws Exception {
		try {
			mapper.deleteQna(qnaNum);
			
		} catch (Exception e) {
			log.info("deleteQna : ", e);
			
			throw e;
		}
		
	}
	
	@Override
	public List<ProductQna> getQnaList(long productNum) {
		List<ProductQna> list = null;
		
		try {
			list = mapper.getQnaList(productNum);
			
			for(ProductQna dto : list) {
				dto.setName(myUtil.nameMasking(dto.getName()));
			}
			
		} catch (Exception e) {
			log.info("getQnaList : ", e);
			
			throw e;
		}
		
		return list;
	}
	
	@Override
	public List<ProductQna> getMyQnaList(Map<String, Object> map) {
		List<ProductQna> list = null;
		
		try {
			list = mapper.getMyQnaList(map);
	
			
		} catch (Exception e) {
			log.info("getMyQnaList : ", e);
			
			throw e;
		}
		
		return list;
	}
	
	@Override
	public List<ProductQna> getAllQnaList(Map<String, Object> map) {
		List<ProductQna> list = null;
		
		try {
			list = mapper.getAllQnaList(map);
			
		} catch (Exception e) {
			log.info("getAllQnaList : ", e);
			
			throw e;
		}
		
		return list;
	}
	
	

	@Override
	public int getDataCount(Map<String, Object> map) {
		int count = 0;
		
		try {
			count = mapper.getDataCount(map);
			
		} catch (Exception e) {
			log.info("getDataCount : ", e);
			
			throw e;
		}
		
		return count;
	}


	@Override
	public int getMyQnaDataCount(long memberId) {
		int count = 0;
		
		try {
			count = mapper.getMyQnaDataCount(memberId);
			
		} catch (Exception e) {
			log.info("getMyQnaDataCount : ", e);
			
			throw e;
		}
		
		return count;
	}

	@Override
	public ProductQna findByQnaNum(long qnaNum) {
		ProductQna dto = null;
		
		try {
			dto = mapper.findByQnaNum(qnaNum);
			
		} catch (Exception e) {
			log.info("findByQnaNum : ", e);
			
			throw e;
		}
		
		return dto;
	}

}
