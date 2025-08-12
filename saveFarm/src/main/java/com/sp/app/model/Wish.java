package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Wish {
	private long wishNum;
	private String wishDate;
	private long memberId;
	private Long productNum;

	private String productName;
	private int unitPrice;
	private int discountRate;
	private int discountedPrice;
	private int deliveryFee;
	private String mainImageFilename;
	
	private int cartItemCount;
}
