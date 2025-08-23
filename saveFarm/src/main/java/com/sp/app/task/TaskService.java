package com.sp.app.task;


import com.sp.app.model.PackageOrder;

public interface TaskService {
	public void checkDeadline();
	public void checkSubDate();
	public PackageOrder packagePicker(Long memberId);
	public long pickRandomExcluding(long num1, long num2);
}
