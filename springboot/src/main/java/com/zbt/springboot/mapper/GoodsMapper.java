package com.zbt.springboot.mapper;


//数据库查询的接口专门用来和数据库交互用的

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.zbt.springboot.entity.Goods;
import com.zbt.springboot.entity.User;
import org.apache.ibatis.annotations.*;
import java.util.List;

public interface GoodsMapper extends BaseMapper<Goods> {

//        @Select("select * from where stuNum = #{stuNum}")
//        List<Goods> MyGoods(String stuNum);
}
