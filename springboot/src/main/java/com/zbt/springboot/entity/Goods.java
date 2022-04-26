package com.zbt.springboot.entity;


import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data // 创建setter和getter
@AllArgsConstructor // 创建有参构造函数
@NoArgsConstructor // 创建无参构造

@TableName(value = "goods")
public class Goods {
    @TableId // 需要指定主键
    private int goodsId;

    private String goodsName;
    private String stuNum;
    private String classification; // 物品分类
    private String category;
    private String place;
    private String contactInfo;
    private String remarks;
    private String time;
//    private String cardId;
    private String goodsImg;
    private String isFind;

}
