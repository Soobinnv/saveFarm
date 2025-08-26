package com.sp.app.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.concurrent.atomic.AtomicLong;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.PackageMapper;
import com.sp.app.mapper.ProductMapper;
import com.sp.app.model.PackageOrder;
import com.sp.app.model.Product;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class packageServiceImpl implements packageService {

	private final PackageMapper mapper;
	private final ProductMapper productMapper;
	private static AtomicLong count = new AtomicLong(0);


	@Override
	public String subPackageNumber() {
		// 상품 주문 번호 생성
		String result = "";

		try {
			Calendar cal = Calendar.getInstance();
			String y = String.format("%04d", cal.get(Calendar.YEAR));
			String m = String.format("%02d", (cal.get(Calendar.MONTH) + 1));
			String d = String.format("%03d", cal.get(Calendar.DATE) * 7);

			String preNumber = y + m + d;
			String savedPreNumber = "0";
			long savedLastNumber = 0;
			String maxOrderNumber = mapper.findByMaxsubNumber(preNumber);
			if (maxOrderNumber != null && maxOrderNumber.length() > 9) {
				savedPreNumber = maxOrderNumber.substring(0, 9);
				savedLastNumber = Long.parseLong(maxOrderNumber.substring(9));
			}

			long lastNumber = 2;
			if (!preNumber.equals(savedPreNumber)) {
				count.set(0);
				lastNumber = count.incrementAndGet();
			} else {
				lastNumber = count.incrementAndGet();

				if (savedLastNumber >= lastNumber) {
					count.set(savedLastNumber);
					lastNumber = count.incrementAndGet();
				}
			}

			result = preNumber + String.format("%09d", lastNumber);

			System.out.println(result);
		} catch (Exception e) {
			log.info("productOrderNumber : ", e);
		}

		return result;
	}

	@Override
	public void insertPackageOrder(PackageOrder dto) throws Exception {
		try {
			// 구독현황 저장
			mapper.insertsubStatus(dto);
			
			Long salaldNum =dto.getSaladPackageNum();
			Long homeNum=dto.getHomePackageNum();
			
			if(salaldNum == 0) {
				dto.setSaladPackageNum(null);
			}else if(homeNum == 0) {
				dto.setHomePackageNum(null);
			}
			
			
			
			// 구독 패키지 저장
			mapper.insertsubPackage(dto);
			
			for(int i=0; i < dto.getProductNums().size(); i++) {
				dto.setProductNum(dto.getProductNums().get(i));
				dto.setItemPrice(dto.getItemPrices().get(i));
				dto.setCount(dto.getCounts().get(i));
				
				// 구독상품 저장
				mapper.insertsubItem(dto);
				
				// 재고 감소
				mapper.updateProductStockDec(dto);
			}
			
			// 구독 배송지 저장
			mapper.insertsubDestination(dto);
			
			
		} catch (Exception e) {
			log.info("insertPackageOrder : ",e);
			
			throw e;
		}

	}

	@Override
	public PackageOrder setMysubInfo(String subNum) throws Exception {
		PackageOrder dto = null;
		
		try {
			dto = mapper.findBySubnum(subNum);
			
			 List<Long> productNums = new ArrayList<>();
			 List<Integer> itemPrices = new ArrayList<>();
			 List<Integer> counts = new ArrayList<>();
			
			
			PackageOrder packageInfo = mapper.subPackageinfo(dto.getSubNum());
		    List<PackageOrder> items = mapper.subItemList(dto.getSubNum());

		    dto.setHomePackageNum(packageInfo.getHomePackageNum());
		    dto.setSaladPackageNum(packageInfo.getSaladPackageNum());
		    dto.setPackagePrice(packageInfo.getPackagePrice());
			
		    dto.setProductNums(items.stream().map(PackageOrder::getProductNum).toList());
	        dto.setItemPrices(items.stream().map(PackageOrder::getItemPrice).toList());
	        dto.setCounts(items.stream().map(PackageOrder::getCount).toList());
	        
	        
	        if (dto.getProductNames() == null) {
		        dto.setProductNames(new ArrayList<>());
		    }
		    if (dto.getMainImageFileNames() == null) {
		        dto.setMainImageFileNames(new ArrayList<>());
		    }
	        
	        
	        for (int j = 0; j < items.size(); j++) {   
		        Product productInfo = productMapper.getProductInfo(items.get(j).getProductNum());
		        
		        dto.getProductNames().add(productInfo.getProductName());
	            dto.getMainImageFileNames().add(productInfo.getMainImageFilename());
	        }
		} catch (Exception e) {
		}
		
		
		return dto;
	}


}
