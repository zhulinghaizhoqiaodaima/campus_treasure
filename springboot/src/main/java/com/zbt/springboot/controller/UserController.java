package com.zbt.springboot.controller;


import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.poi.excel.ExcelReader;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.zbt.springboot.common.Constants;
import com.zbt.springboot.common.Result;
import com.zbt.springboot.controller.dto.UserDTO;
import com.zbt.springboot.entity.User;
import com.zbt.springboot.service.UserService;
import com.zbt.springboot.utils.TokenUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.List;


@RestController
@RequestMapping("/user")
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }


    // 后台管理请求登录
    @PostMapping ("/loginAdmin")// RequestBody->把前端传过来的json对象转为java对象
    public Result loginAdmin(@RequestBody(required=false) UserDTO userDTO) {
        System.out.println(userDTO);
        String stuNum = userDTO.getStuNum();
        String password = userDTO.getPassword();

        if (StrUtil.isBlank(stuNum) || StrUtil.isBlank(password)) {
            return Result.error(Constants.CODE_400,"账户或密码不能为空");
        }

        UserDTO dto = userService.loginAdmin(userDTO);
        return Result.success(dto);
    }

    //  新增或者更新
    @PostMapping("/save") // RequestBody->把前端传过来的json对象转为java对象
    public Result save(@RequestBody User user) {
        //新增或者更新
       return Result.success(userService.saveUser(user));
    }

    //  注册
    @PostMapping("/register") // RequestBody->把前端传过来的json对象转为java对象
    public Result register(@RequestBody User user) {
        //新增或者更新
        return Result.success(userService.RegisterUser(user));
    }

    // 查询所有
    @GetMapping
    public List<User> findAll() {
        return userService.list();
    }

    //删除数据
    @DeleteMapping("/{stuNum}")
    public boolean delete(@PathVariable String stuNum) {
       return userService.removeById(stuNum);
    }

    //批量删除
    @PostMapping("/batch")
    public boolean deleteBatch(@RequestBody List<String> stuNums) {
        return userService.removeBatchByIds(stuNums);
    }

    // 分页查询
    //@RequestParam 接收 参数
    // pageNum = (pageNum-1) * pageSize
    // pageSize =pageSize;
//    @GetMapping("/page")

//    public Map<String, Object> findPage(@RequestParam Integer pageNum,@RequestParam Integer pageSize,
//                                        @RequestParam String nickname,@RequestParam String stuNum, @RequestParam String phone) {
//
//        pageNum = (pageNum -1) * pageSize;
//        nickname = "%"+nickname + "%";
//        stuNum = "%"+stuNum + "%";
//        phone = "%"+phone + "%";
//        List<User> data = userMapper.SelectPage(pageNum, pageSize,nickname,stuNum,phone);
//        Integer total = userMapper.selectTotal(nickname,stuNum,phone);
//        Map<String, Object> res = new HashMap<>();
//        res.put("data",data);
//        res.put("total",total);
//        return res;
//    }

    @PostMapping("/getPerson/{stuNUm}")
    public Result getPersonMsg(@PathVariable String stuNUm) {
//        User currentUser = TokenUtils.getCurrentUser();
//        if (currentUser != null) {
//            System.out.println("用户昵称============== " + currentUser.getNickname());
//        }else {
//            System.out.println("没有数据=================");
//        }
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("stuNUm",stuNUm);
        return Result.success(userService.getOne(queryWrapper));
    }
    @DeleteMapping("/personMsg/{stuNUm}")
    public Result personMsg(@PathVariable String stuNUm) {
//        User currentUser = TokenUtils.getCurrentUser();
//        if (currentUser != null) {
//            System.out.println("用户昵称============== " + currentUser.getNickname());
//        }else {
//            System.out.println("没有数据=================");
//        }
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("stuNUm",stuNUm);
        return Result.success(userService.getOne(queryWrapper));
    }

    // 分页查询-mybatis-plus的方式
    @GetMapping("/page")
    public Result findPage(@RequestParam Integer pageNum, @RequestParam Integer pageSize,
                           @RequestParam(defaultValue = "") String nickname, @RequestParam(defaultValue = "")
                                            String stuNum, @RequestParam(defaultValue = "") String phone) {
        IPage<User> page = new Page<>(pageNum,pageSize);
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        // 搜查数据不能为null,即键值不能为空
        queryWrapper.like("nickname",nickname);
        queryWrapper.like("stuNum",stuNum);
        queryWrapper.like("phone",phone);



        return Result.success(userService.page(page, queryWrapper));
    }

    /**
     * excel 导入
     * @param file
     * @throws Exception
     */
    @PostMapping("/import")
    public Boolean imp(MultipartFile file) throws Exception {
        System.out.println(file);
        InputStream inputStream = file.getInputStream();
        ExcelReader reader = ExcelUtil.getReader(inputStream);
        // 方式1：(推荐) 通过 javabean的方式读取Excel内的对象，但是要求表头必须是英文，跟javabean的属性要对应起来
//        List<User> list = reader.readAll(User.class);

        // 方式2：忽略表头的中文，直接读取表的内容
        List<List<Object>> list = reader.read(1);
        List<User> users = CollUtil.newArrayList();
        for (List<Object> row : list) {
            User user = new User();
            user.setNickname(row.get(0).toString());
            user.setStuNum(row.get(1).toString());
            user.setPwd(row.get(2).toString());
            user.setGrade(row.get(3).toString());
            user.setPhone(row.get(4).toString());
            user.setAvatar(row.get(5).toString());
            users.add(user);
        }

        userService.saveBatch(users);
        return true;
    }

    /**
     * 导出接口
     */
    @GetMapping("/export")
    public void export(HttpServletResponse response) throws Exception {
        // 从数据库查询出所有的数据
        List<User> list = userService.list();
        // 通过工具类创建writer 写出到磁盘路径
//        ExcelWriter writer = ExcelUtil.getWriter(filesUploadPath + "/用户信息.xlsx");
        // 在内存操作，写出到浏览器
        ExcelWriter writer = ExcelUtil.getWriter(true);
        //自定义标题别名
        writer.addHeaderAlias("nickname", "用户名");
        writer.addHeaderAlias("stuNum", "学号");
        writer.addHeaderAlias("pwd", "密码");
        writer.addHeaderAlias("grade", "年级");
        writer.addHeaderAlias("phone", "电话");
        writer.addHeaderAlias("avatar", "头像");

        // 一次性写出list内的对象到excel，使用默认样式，强制输出标题
        writer.write(list, true);

        // 设置浏览器响应的格式
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;charset=utf-8");
        String fileName = URLEncoder.encode("用户信息", "UTF-8");
        response.setHeader("Content-Disposition", "attachment;filename=" + fileName + ".xlsx");

        ServletOutputStream out = response.getOutputStream();
        writer.flush(out, true);
        out.close();
        writer.close();

    }

}
