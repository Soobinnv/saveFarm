package com.sp.app.admin.model;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DashboardManage {
	
	private String orderNum;
	private String orderDate;
	private long payment;
	
	private int detailState;
	
	
	private long returnNum;
    private String reqDate;
    private String reason;
    private int quantity;
    // status - 0: 신청, 1: 처리중, 2: 처리 완료
    private int status;
    private String returnDate;
    
    private long orderDetailNum;
    private long salePrice;
    private long price;
    
    // 반품 첨부 이미지
    private long returnImageNum;
    private String returnImageFilename;
    
    private List<MultipartFile> returnImages;
	
    // 정기배송
    private String payDate;
    private long totalPay;
    
	
	
}
