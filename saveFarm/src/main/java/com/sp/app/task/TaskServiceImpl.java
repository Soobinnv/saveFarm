package com.sp.app.task;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

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
			// 오늘 일자 기준 한달전에 결제일이었던 데이터중에 연장여부가 1(연장), 4(대기중) 데이터 검색
			List<PackageOrder> list = packageMapper.findByPayData();
			
			for(PackageOrder dto : list) {
				
				// 전달 또는 수정대기중인 데이터 탐색후 dto에 저장
				PackageOrder PackageInfo = packageMapper.subPackageinfo(dto.getSubNum());
				PackageOrder subItemInfo = packageMapper.subPackageinfo(dto.getSubNum());
				
				dto.setHomePackageNum(PackageInfo.getHomePackageNum());
				dto.setSaladPackageNum(PackageInfo.getSaladPackageNum());
				dto.setProductNums(subItemInfo.getProductNums());
				dto.setItemPrices(subItemInfo.getItemPrices());
				dto.setCounts(subItemInfo.getCounts());
				
				// 최근 두달의 페키지 번호를 제외한 나머지 랜덤
				PackageOrder randomInfo = packagePicker(dto.getMemberId());
				dto.setHomePackageNum(randomInfo.getHomePackageNum());
				dto.setSaladPackageNum(randomInfo.getSaladPackageNum());
				
				// 개월수 증가, subNum set
				dto.setSubMonth(dto.getSubMonth()+1);
				dto.setSubNum(packageService.subPackageNumber());
				
				// 결제
				packageService.insertPackageOrder(dto);
				
			}
			
		} catch (Exception e) {
			log.info("checkSubDate : ",e);
		}
	}

	@Override
	public PackageOrder packagePicker(Long memberId) {
		
		PackageOrder random = null;
		
		try {
			List<PackageOrder> prePackageinfo = packageMapper.findBysubData(memberId);
			
			long prehomeNum[]=null;
			long presaladNum[]=null;
			
			for(int i =0 ; i<2; i++) {
				prehomeNum[i]= prePackageinfo.get(i).getHomePackageNum();
				presaladNum[i]= prePackageinfo.get(i).getSaladPackageNum();
			}
			
			// 둘다 null인 경우에는 random 돌리지 않음
			if(prehomeNum[0] != 0 || prehomeNum[1] != 0) {
				random.setHomePackageNum(pickRandomExcluding(prehomeNum[0], prehomeNum[1])); 
			}else if(presaladNum[0] != 0 || presaladNum[1] != 0) {
				random.setSaladPackageNum(pickRandomExcluding(presaladNum[0], presaladNum[1])%6); 
			}
			
		} catch (Exception e) {
			log.info("packagePicker : ",e);
		}
		
		return random;
	}

	@Override
	public long pickRandomExcluding(long num1, long num2) {
		List<Integer> candidates = new ArrayList<>();
		
		if(num1>6 && num2>6) {
			num1= num1%6;
			num2= num2%6;
		}
		
        for (int i = 1; i <= 6; i++) {
            if (i != num1 && i != num2) { 
                candidates.add(i);
            }
        }
        Random random = new Random();
        return candidates.get(random.nextInt(candidates.size()));
		
	}


}
