package com.zbt.springboot.controller.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 接收前端后台登录请求的账号，密码
 */
@Data //创建getter方法和setter方法
@AllArgsConstructor // 创建有参构造函数
@NoArgsConstructor // 创建无参构造

public class UserDTO {
    private String nickname;
    private String password;
    private String phone;
    private  String grade;
    private String avatar;
    private String stuNum;
    private String token;
    private String iscontactInfo;
    private boolean isAdmin;
}
