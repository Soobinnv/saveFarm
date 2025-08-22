package com.sp.app.farm.service;

import java.sql.SQLException;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.farm.mapper.VarietyMapper;
import com.sp.app.farm.model.Variety;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class VarietyServiceImpl implements VarietyService{
	private final VarietyMapper mapper; 
	
	@Override
	public void insertVariety(Variety dto) throws SQLException {
		try {
			mapper.insertVariety(dto);
		} catch (Exception e) {
			log.info("insertFarm : ", e);
			throw e;
		}
	}

	@Override
	public void updateVariety(Variety dto) throws SQLException {
		try {
			mapper.updateVariety(dto);
		} catch (Exception e) {
			log.info("updateVariety : ", e);
			throw e;
		}
	}

	@Override
	public void deleteVariety(Map<String, Object> map) throws SQLException {
		try {
			mapper.deleteVariety(map);
		} catch (Exception e) {
			log.info("deleteSupply : ", e);
			throw e;
		}
		
	}

	@Override
	public Variety findByVarietyNum(Long varietyNum) {
		Variety dto = null;
		
		try {
	    	dto = mapper.findByVarietyNum(varietyNum);
	    	if (dto == null) { 
				return null;
			}
	    } catch (Exception e) {
	        log.info("findByVarietyNum : ", e);
	    }
	    return dto;
	}

	@Override
	public int existsVarietyName(String varietyName) {
		int count = 0;
		
	    try {
	    	
	    	if(mapper.existsVarietyName(varietyName) != 0 ) {
				count = mapper.existsVarietyName(varietyName);
			}
	    } catch (Exception e) {
	        log.info("existsVarietyName : ", e);
	    }
	    return count;
	}

	@Override
	public List<Variety> listVariety(Map<String, Object> map) {
		List<Variety> list = null;
			
			try {
		        list = mapper.listVariety(map);
		    } catch (Exception e) {
		        log.info("listVariety : ", e);
		}
		
		return list;
	}

	@Override
	public int VarietyCount(Map<String, Object> map) {
		int count = 0;
		
	    try {
	    	
	    	if(mapper.VarietyCount(map) != 0 ) {
				count = mapper.VarietyCount(map);
			}
	    } catch (Exception e) {
	        log.info("VarietyCount : ", e);
	    }
	    return count;
	}

	@Override
	public List<Variety> listAll() {
		List<Variety> list = null;
		
		try {
	        list = mapper.listAll();
	    } catch (Exception e) {
	        log.info("listAll : ", e);
	    }
	
		return list;
	}

	@Override
	public int allCount() {
		int count = 0;
		
	    try {
	    	
	    	if(mapper.allCount() != 0 ) {
				count = mapper.allCount();
			}
	    } catch (Exception e) {
	        log.info("allCount : ", e);
	    }
	    return count;
	}

}
