package com.zbt.springboot;

import com.zbt.springboot.controller.aliyun.OCR;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.io.FileInputStream;
import java.io.FileNotFoundException;


@SpringBootApplication
public class SpringbootApplication {

    public static void main(String[] args) {
        SpringApplication.run(SpringbootApplication.class, args);
//            String img = "http://localhost:8088/file/be18f669e8b342a7863e3a7ae32f68be.png";
//            OCR.aliyunAnalysisPic(img);

    }

}
