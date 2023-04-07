package com.project;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@EnableJpaAuditing // base time entity 사용을 위한 어노테이션
@SpringBootApplication
public class TodakTodakApplication {
    
    public static void main(String[] args) {
        SpringApplication.run(TodakTodakApplication.class, args);
    }
}
