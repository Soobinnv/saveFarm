package com.sp.app.farm.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.farm.model.Supply;
import com.sp.app.farm.model.Variety;


@Mapper
public interface SupplyMapper {
    // 기본 CRUD
    public void insertSupply(Supply dto) throws SQLException;
    public void updateSupply(Supply dto) throws SQLException;
    public int updateState(Map<String, Object> map) throws SQLException;        
    public void updateState1(Map<String, Object> map) throws SQLException;     
    public void updateState2(Map<String, Object> map) throws SQLException;       
    public void updateRescuedApply(Map<String, Object> map) throws SQLException;        
    public void deleteSupply(Map<String, Object> map) throws SQLException;      

    public List<Variety> listFarmVarieties(Map<String, Object> map);
    
    // 관리자용 리스트
    public List<Supply> listManageSupply(Map<String, Object> map);
    
    // 리스트 & 카운트
    public List<Supply> listSupply(Map<String, Object> map);
    public int listSupplyCount(Map<String, Object> map);

    // 조회
    public Supply findBySupplyNum(Long supplyNum);

    // 특정 농가의 납품목록
    public List<Supply> listByFarm(Long farmNum);
	public int farmSupplyListCount(Long farmNum);
	
	// 승인여부 대상 조회용
	public List<Supply> listByState(int state);
 	public int stateListCount(int state);
 	
 	// 긴급구출상품신청여부조회용
 	public List<Supply> listFindRescuedApply(int rescuedApply);
 	public int rescuedApplyListCount(int rescuedApply);
     	
    // 시퀀스/일괄처리
    public Long nextSupplyNum();

    // 통계/집계
    public List<Map<String, Object>> monthlyAmount(Map<String, Object> map);
    public Map<String, Object> totalsByState(Map<String, Object> map);
    public List<Map<String, Object>> topVarieties(Map<String, Object> map);
    
    // 이전 글/다음 글
    public Supply findByPrev(Map<String, Object> map);
    public Supply findByNext(Map<String, Object> map);


}

