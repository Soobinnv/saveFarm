package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Package {
	private long packageNum;
	private String packageName;
	private int price;
	private String content;
}
