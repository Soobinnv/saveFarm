package com.sp.app.model;



import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class PackageCart {
	private long productNum;
	private String productName;
	private int unitPrice;
	private int quantity;
	private String thumb;
}

