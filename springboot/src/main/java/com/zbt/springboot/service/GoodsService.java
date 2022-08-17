package com.zbt.springboot.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.zbt.springboot.mapper.GoodsMapper;
import org.springframework.stereotype.Service;
import com.zbt.springboot.entity.Goods;

@Service
public class GoodsService extends ServiceImpl<GoodsMapper,Goods> {
    //更新物品信息
    public boolean updateGoods(Goods one) {

        QueryWrapper<Goods> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("goodsId",one.getGoodsId());
        if (getOne(queryWrapper) == null) {
            return save(one); //mybatis-plus提供的方法表示插入数据
        }else {
            return updateById(one); //mybatis-plus提供的方法表示更新数据
        }
    }
    public boolean saveGoods(Goods one) {
        return save(one); //mybatis-plus提供的方法表示插入数据
    }
//    public List<Goods> myGoods(String stuNum) {
//        GoodsService goodsService = new GoodsService();
//        QueryWrapper queryWrapper = new QueryWrapper<>();
//        queryWrapper.like("stuNum",stuNum);
//        System.out.println(getMap(queryWrapper));
//        List<Goods> goods = goodsService.list(getMap(queryWrapper));
//        return goods;
//
//    }
}
