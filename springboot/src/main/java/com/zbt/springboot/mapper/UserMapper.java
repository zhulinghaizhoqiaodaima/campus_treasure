package com.zbt.springboot.mapper;
//数据库查询的接口专门用来和数据库交互用的

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.zbt.springboot.entity.User;
import org.apache.ibatis.annotations.*;

import java.util.List;
public interface UserMapper extends BaseMapper<User> {
//    @Select("select * from User")
//    List<User> findAll();
//
//    @Insert("INSERT INTO USER(nickname,stuNum,pwd,grade,phone) VALUES(#{nickname},#{stuNum},#{pwd},#{grade},#{phone})")
//    int insert(User user);
//
//    int update(User user);
//
//    @Delete("delete from user where stuNum = #{stuNum}")
//    Integer deleteByStuNum(@Param("stuNum") String stuNum);
//
//    @Select("select * from user where nickname like #{nickname} and stuNum like #{stuNum} and phone like #{phone} limit #{pageNum},#{pageSize}")
//    List<User> SelectPage(Integer pageNum, Integer pageSize,String nickname,String stuNum,String phone);
//
//    @Select("select count(*)from user where nickname like #{nickname} and stuNum like #{stuNum} and phone like #{phone}")
//    Integer selectTotal(String nickname,String stuNum,String phone);
}
