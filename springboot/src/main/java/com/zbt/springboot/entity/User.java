package com.zbt.springboot.entity;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data // 创建setter和getter
@AllArgsConstructor // 创建有参构造函数
@NoArgsConstructor // 创建无参构造

@TableName(value = "user")
public class User {
    private String nickname;
    @TableId // 需要指定主键
    private String stuNum;
//    @JsonIgnore 忽略特定字段
    private String pwd;
    private String phone;
    private  String grade;
    @TableField(value = "avatar_url")
    private String avatar;
    private Date createTime;
    private String iscontactInfo;
    private boolean isAdmin;



}
