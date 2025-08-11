package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class subItem {
	private long itemNum;
	private int itemPrice;
	private int count;
	private long subNum;
	private long productNum;
}
