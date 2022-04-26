package com.zbt.springboot.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.zbt.springboot.common.Result;
import com.zbt.springboot.entity.User;
import com.zbt.springboot.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.ServletContext;
import java.io.FileInputStream;
import java.io.FileNotFoundException;

@RestController
@RequestMapping("/orc")
public class OrcController {
    private final UserService userService;

    public OrcController(UserService userService) {
        this.userService = userService;
    }

    //匹配物品失主
    @GetMapping("/matching/{stuNUm}")
    public Result matching(@PathVariable String stuNUm) {
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("stuNUm",stuNUm);

        return Result.success(userService.getOne(queryWrapper));
    }
    @GetMapping("/{url}")
    public Result personMsg(@PathVariable String url) {
        //读取本地图片输入流
        try {
            FileInputStream inStream = new FileInputStream("D:\\前端全栈之路\\外包\\毕设项目\\" +
                    "campus_treasure\\springboot\\files\\0da76bce12724e6fa783ca9d2e23bb2a.jpg");
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

        return Result.success();
    }
}
