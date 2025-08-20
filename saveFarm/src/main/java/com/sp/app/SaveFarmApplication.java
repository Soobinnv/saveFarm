package com.sp.app;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableScheduling
@SpringBootApplication
public class SaveFarmApplication {

	public static void main(String[] args) {
		SpringApplication.run(SaveFarmApplication.class, args);
	}

}
