package com.zbt.springboot.service;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.zbt.springboot.common.Constants;
import com.zbt.springboot.controller.dto.UserDTO;
import com.zbt.springboot.entity.User;
import com.zbt.springboot.exception.ServiceException;
import com.zbt.springboot.mapper.UserMapper;
import com.zbt.springboot.utils.TokenUtils;
import org.springframework.stereotype.Service;


@Service
public class UserService extends ServiceImpl<UserMapper,User> {

    public User saveUser(User one) {
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("stuNum",one.getStuNum());
//        System.out.println(queryWrapper+"===================");
        if (getOne(queryWrapper) == null) {
            save(one);
        }else {
            updateById(one); //mybatis-plus提供的方法表示更新数据
        }
        return  one;//mybatis-plus提供的方法表示插入数据
    }

    public boolean RegisterUser(User one) {
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("stuNum",one.getStuNum());
        if (getOne(queryWrapper) == null) {
            return save(one); //mybatis-plus提供的方法表示插入数据
        }else {
            return false; //mybatis-plus提供的方法表示更新数据
        }
    }

    public UserDTO loginAdmin(UserDTO userDTO) {
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("stuNum",userDTO.getStuNum());
        queryWrapper.eq( "pwd",userDTO.getPassword());
        User one;
        try {
             one = getOne(queryWrapper); // 从数据查询出的用户数据
        } catch (Exception e) {
            e.printStackTrace();
            throw  new ServiceException(Constants.CODE_500,"系统错误");
        }

        if (one != null) {
            BeanUtil.copyProperties(one,userDTO,true);
            // 设置token
            String token = TokenUtils.goTaken(one.getStuNum(), one.getPwd());
            userDTO.setToken(token);
            return userDTO;
        }else {
            throw new ServiceException(Constants.CODE_600,"账户或密码错误");
        }
    }

}
