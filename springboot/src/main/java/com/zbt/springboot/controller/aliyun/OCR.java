package com.zbt.springboot.controller.aliyun;

import com.zbt.springboot.controller.aliyun.HttpUtils;
import org.apache.http.HttpResponse;
import org.apache.http.util.EntityUtils;


import java.util.HashMap;
import java.util.Map;

public class OCR {
    public static void aliyunAnalysisPic(String img){
        String host = "https://lysbwdxs.market.alicloudapi.com";
        String path = "/ocrservice/document";
        String method = "POST";
        //自己的appCode
        String appcode = "4bce70e7eda54e2ca5b41ba1eb7eab89";
        Map<String, String> headers = new HashMap<String, String>();
        //最后在header中的格式(中间是英文空格)为Authorization:APPCODE ****************
        headers.put("Authorization", "APPCODE " + appcode);
        //根据API的要求，定义相对应的Content-Type
        headers.put("Content-Type", "application/json; charset=UTF-8");
        Map<String, String> querys = new HashMap<String, String>();
        String bodys = "{\"img\":\"\",\"url\":\""+img+"\",\"prob\":false,\"charInfo\":false,\"rotate\":false,\"table\":false}";

        try {
            /**
             * 重要提示如下:
             * HttpUtils请从
             * https://github.com/aliyun/api-gateway-demo-sign-java/blob/master/src/main/java/com/aliyun/api/gateway/demo/util/HttpUtils.java
             * 下载
             *
             * 相应的依赖请参照
             * https://github.com/aliyun/api-gateway-demo-sign-java/blob/master/pom.xml
             */
            HttpResponse response = HttpUtils.doPost(host, path, method, headers, querys, bodys);
            System.out.println(response.toString());
            //获取response的body
            System.out.println(EntityUtils.toString(response.getEntity()));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
