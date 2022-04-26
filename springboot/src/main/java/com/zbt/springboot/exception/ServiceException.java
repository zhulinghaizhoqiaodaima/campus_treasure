package com.zbt.springboot.exception;

import lombok.Data;

/**
 * 自定义的一种异常,
 */
@Data // 全局异常处理器
public class ServiceException extends RuntimeException{
    private String code;

    public ServiceException(String code,String msg) {
        super(msg);
        this.code = code;
    }
}
