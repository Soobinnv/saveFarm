package com.sp.app.farm.service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.farm.mapper.SupplyMapper;
import com.sp.app.farm.model.MyFarmSale;
import com.sp.app.farm.model.Supply;
import com.sp.app.farm.model.Variety;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class SupplyServiceImpl implements SupplyService {

	private final SupplyMapper mapper;
	
	
	@Override
	public void insertSupply(Supply dto) {
	    try {
	        mapper.insertSupply(dto);
	    } catch (Exception e) {
	        log.info("insertSupply : ", e);
	    }
	}
	
	@Override
	public void updateSupply(Supply dto) {
	    try {
	        mapper.updateSupply(dto);
	    } catch (Exception e) {
	        log.info("updateSupply : ", e);
	    }
	}
	
	@Override
	public int updateState(Map<String, Object> map) {
		int count = 0;
	    try {
	    	count = mapper.updateState(map);
	    } catch (Exception e) {
	        log.info("updateState : ", e);
	    }
	    
	    return count;
	}
	
	
	@Override
	public void updateState1(Long supplyNum) throws Exception {
		try {
	        mapper.updateState1(supplyNum);
	    } catch (Exception e) {
	        log.info("updateState : ", e);
	    }
	}

	@Override
	public void updateState2(Long supplyNum) throws Exception {
		try {
	        mapper.updateState2(supplyNum);
	    } catch (Exception e) {
	        log.info("updateState : ", e);
	    }
	}
	@Override
	public void updateRescuedApply(Map<String, Object> map) throws Exception {
		try {
			mapper.updateRescuedApply(map);
		} catch (Exception e) {
			log.info("updateRescuedApply : ", e);
			throw e;
		}
	}

	@Override
	public void deleteSupply(Map<String, Object> map) throws Exception {
		try {
			mapper.deleteSupply(map);
		} catch (Exception e) {
			log.info("deleteSupply : ", e);
			throw e;
		}
		
	}
	
	// ---------------------------- 관리자용
	
	@Override
	public List<Supply> listManageSupply(Map<String, Object> map) {
		List<Supply> list = null;
		
		try {
	        list = mapper.listManageSupply(map);
	    } catch (Exception e) {
	        log.info("listSupply : ", e);
	    }
		
		return list;
	}
	
	// -----------------------------------------
	
	@Override
	public List<Supply> listSupply(Map<String, Object> map) {
	    List<Supply> list = null;
		
		try {
	        list = mapper.listSupply(map);
	    } catch (Exception e) {
	        log.info("listSupply : ", e);
	    }
		
		return list;
	}

	@Override
	public int listSupplyCount(Map<String, Object> map) {
		int count = 0;
		
	    try {
	    	
	    	if(mapper.listSupplyCount(map) != 0 ) {
				count = mapper.listSupplyCount(map);
			}
	    } catch (Exception e) {
	        log.info("listSupplyCount : ", e);
	    }
	    return count;
	}

	@Override
	public Supply findBySupplyNum(Long supplyNum) {
		Supply dto = null;
		
	    try {
	    	dto = mapper.findBySupplyNum(supplyNum);
	    	if (dto == null) { 
				return null;
			}
	    } catch (Exception e) {
	        log.info("findBySupplyNum : ", e);
	    }
	    return dto;
	}

	@Override
	public List<Supply> listByFarm(Long farmNum) {
		List<Supply> list = null;
		
		try {
			list = mapper.listByFarm(farmNum);
	    } catch (Exception e) {
	        log.info("listByFarm : ", e);
	    }
		return list;
	}
	
	@Override
	public int farmSupplyListCount(Long farmNum) {
		int count = 0;
		
		try {
			if(mapper.farmSupplyListCount(farmNum) != 0 ) {
				count = mapper.farmSupplyListCount(farmNum);
			}
		} catch (Exception e) {
			log.info("stateListCount : ", e);
		}
		
		return count;
	}

	@Override
	public List<Supply> listByState(int state) {
		List<Supply> list = null;
		try {
			list = mapper.listByState(state);
	    } catch (Exception e) {
	        log.info("listByState : ", e);
	    }
		return list;
	}

	@Override
	public int stateListCount(int state) {
		int count = 0;
		
		try {
			if(mapper.stateListCount(state) != 0 ) {
				count = mapper.stateListCount(state);
			}
		} catch (Exception e) {
			log.info("stateListCount : ", e);
		}
		
		return count;
	}

	@Override
	public List<Supply> listFindRescuedApply(int rescuedApply) {
		List<Supply> list = null;
		
		try {
			list = mapper.listFindRescuedApply(rescuedApply);
		} catch (Exception e) {
			log.info("listFindRescuedApply : ", e);
		}
		
		return list;
	}

	@Override
	public int rescuedApplyListCount(int rescuedApply) {
		int count = 0;
		
		try {
			if(mapper.rescuedApplyListCount(rescuedApply) != 0 ) {
				count = mapper.rescuedApplyListCount(rescuedApply);
			}
		} catch (Exception e) {
			log.info("rescuedApplyListCount : ", e);
		}
		
		return count;
	}

	
	@Override
	public Long nextSupplyNum() {
		Long num = null;
	    try {
	    	num =  mapper.nextSupplyNum();
	    } catch (Exception e) {
	        log.info("nextSupplyNum : ", e);
	    }
	    return num;
	}

	@Override
	public List<Map<String, Object>> monthlyAmount(Map<String, Object> map) {
		List<Map<String, Object>> list = null;
		try {
	        // 필요시 날짜 기본값 보정 로직 추가 가능
	        // normalizeDateRange(map);
			list = mapper.monthlyAmount(map);
	    } catch (Exception e) {
	        log.info("monthlyAmount : ", e);
	    }
		return list;
	}
	
	@Override
	public Map<String, Object> totalsByState(Map<String, Object> map) {
	    Map<String, Object> result = null;
	    try {
	        result = mapper.totalsByState(map);
	    } catch (Exception e) {
	        log.info("totalsByState : ", e);
	        return Collections.emptyMap(); // Map 특화된 empty 반환
	    }
	    return result;
	}
	
	@Override
	public List<Map<String, Object>> topVarieties(Map<String, Object> map) {
	    List<Map<String, Object>> list = null;
		try {
			list = mapper.topVarieties(map);
	    } catch (Exception e) {
	        log.info("topVarieties : ", e);
	    }
		return list;
	}
	
	@Override
	public Supply findByPrev(Map<String, Object> map) throws Exception {
		Supply dto = null;
		try {
			dto = mapper.findByPrev(map);
		} catch (Exception e) {
			 log.info("findByPrev : ", e);
		}
		return dto;
	}
	
	@Override
	public Supply findByNext(Map<String, Object> map) throws Exception {
		Supply dto = null;
		try {
			dto = mapper.findByNext(map);
		} catch (Exception e) {
			 log.info("findByNext : ", e);
		}
		return dto;
	}

	@Override
	public List<Variety> listFarmVarieties(Map<String, Object> map) {
		 List<Variety> list = null;
			try {
				list = mapper.listFarmVarieties(map);
		    } catch (Exception e) {
		        log.info("topVarieties : ", e);
		    }
			return list;
	}


}


