package com.zbt.springboot.utils;



import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.StrUtil;
import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTDecodeException;
import com.zbt.springboot.entity.User;
import com.zbt.springboot.service.UserService;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;

@Component
public class TokenUtils {
    private static UserService staticUserService;
    @Resource
    private  UserService userService;
    @PostConstruct
    public void setUserService () {
        staticUserService = userService;
    }
    /**
     * 生成token
     * @return
     */
    public static String goTaken(String stuNum, String pwd) {

        String token= JWT.create().withAudience(stuNum) // 将stuNum作为载荷
                .withExpiresAt(DateUtil.offsetHour(new Date(),2)) // 2小时后token过期
                .sign(Algorithm.HMAC256(pwd)); //
        return token;

    }

    /**
     * 获取当前登录的用户信息
     * @return
     */
    public static User getCurrentUser () {

        try {
            HttpServletRequest request;
            request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
            String token = request.getHeader("token");

            if (token != null) {
                System.out.println("token值:=============" + token);
                String aud = JWT.decode(token).getAudience().get(0);
                return staticUserService.getById(String.valueOf(aud));
            }
        } catch (JWTDecodeException e) {
            return null;
        }

        return null;
    }

}

