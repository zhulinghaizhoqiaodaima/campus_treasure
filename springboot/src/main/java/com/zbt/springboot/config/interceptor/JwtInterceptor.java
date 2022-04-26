package com.zbt.springboot.config.interceptor;

import cn.hutool.core.util.StrUtil;
import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTDecodeException;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.zbt.springboot.common.Constants;
import com.zbt.springboot.entity.User;
import com.zbt.springboot.exception.ServiceException;
import com.zbt.springboot.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 对前端发送的token进行tokena验证
*/
@Component
public class JwtInterceptor implements HandlerInterceptor {

    @Autowired // 注入需要注意
    private UserService userService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {

        String token = request.getHeader("token");
        System.out.println(token);

        //不是映射到方法直接跳过
        if(!(handler instanceof HandlerMethod)) {
            return true;
        }
        // 执行验证
        if(StrUtil.isBlank(token)) {
            throw new ServiceException(Constants.CODE_401,"无token,请重新登录");
        }

        String userId;
        try {
            userId = JWT.decode(token).getAudience().get(0);
        } catch (JWTDecodeException e) {
            throw new ServiceException(Constants.CODE_401,"token验证失败");
        }
        // 根据token中的userid(stuNum) 查询数据库
        User user = userService.getById(userId);
        if (user != null) {
            throw new ServiceException(Constants.CODE_401,"用户不存在请重新登录");
        }

        // 用户密码加签验证
        JWTVerifier jwt = JWT.require(Algorithm.HMAC256(user.getPwd())).build();
        try {
            jwt.verify(token);
        } catch (JWTVerificationException e) {
            throw new ServiceException(Constants.CODE_401,"用户错误请重新登录");
        }

        return true;
    }
}
