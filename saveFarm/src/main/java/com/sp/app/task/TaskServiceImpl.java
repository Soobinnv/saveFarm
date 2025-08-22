package com.sp.app.task;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.sp.app.mapper.PackageMapper;
import com.sp.app.mapper.ProductMapper;
import com.sp.app.model.PackageOrder;
import com.sp.app.model.Product;
import com.sp.app.service.packageService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class TaskServiceImpl implements TaskService {
	private final ProductMapper productMapper;
	private final PackageMapper packageMapper;
	private final packageService packageService;
	
	@Scheduled(cron = "0 0 0 * * *")
	@Override
	public void checkDeadline() {
		LocalDateTime twentyFourHoursLater  = LocalDateTime.now().plusHours(24);
		
		try {
			// 마감 시간이 24시간 이내인 상품 번호
			List<Product> list = productMapper.getRescuedProductNumsClosingSoon(twentyFourHoursLater);
			
			// 구출 상품 정보 테이블 update
			for(Product dto : list) {
				dto.setIsUrgent(1);
				
				productMapper.updateRescuedProduct(dto);
			}
		} catch (Exception e) {
			log.info("checkDeadline: ", e);
		}

	}
	
	@Scheduled(cron = "0 0 0 * * *")
	@Override
	public void checkSubDate() {
		
		try {
			PackageOrder dto = packageMapper.findByPayData();
			dto.setSubNum(packageService.subPackageNumber());
			dto.setSubMonth(dto.getSubMonth()+1);
			
			packageMapper.insertsubStatus(dto);
			
			// Task에서 해줘야 하는거 랜덤으로 패키지 골라서 넣어서 패키지 변경해주기 전달구독 위에 findByPayData join해서 구독 패키지 그대로 추가 구독상품 구독연장 여부 컬럼 추가하고 join 구독연장여부 1이면 전달 정보 그대로 insert
			
			
		} catch (Exception e) {
		}
	}

}
