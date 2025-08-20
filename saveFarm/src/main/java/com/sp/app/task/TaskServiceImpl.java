package com.sp.app.task;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.sp.app.mapper.ProductMapper;
import com.sp.app.model.Product;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class TaskServiceImpl implements TaskService {
	private final ProductMapper productMapper;
	
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

}
