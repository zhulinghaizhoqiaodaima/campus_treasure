package com.zbt.springboot.controller;

import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.SecureUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.zbt.springboot.common.Result;
import com.zbt.springboot.entity.Files;
import com.zbt.springboot.mapper.FileMapper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

/**
 * 文件上传相关接口
 */
@RestController
@RequestMapping("/file")
public class FileController {
    @Value("${file.upload.path}")
    private String fileUploadPath;

    @Resource
    private FileMapper fileMapper;


    @PostMapping("/upload")
    public String upload(@RequestParam MultipartFile file) throws IOException {
        String originalFilename = file.getOriginalFilename();
        String type = FileUtil.extName(originalFilename);
        long size = file.getSize();
        // 判断文件目录是否存在,不存在则新建一个
//        File uploadParentFile = new File(fileUploadPath);
//        if(!uploadParentFile.exists()) {
//            uploadParentFile.mkdirs();
//        }
        // 生成文件唯一的标识码
        String uuid = IdUtil.fastSimpleUUID();
        String fileUuid = uuid+ StrUtil.DOT+type;



        File uploadFile = new File(fileUploadPath+fileUuid);
        if(!uploadFile.getParentFile().exists()) {
            uploadFile.getParentFile().mkdirs();
        }
        String md5;
        String url;
        // 上传文件到磁盘
        file.transferTo(uploadFile);
        // 获取文件md5
        md5 = SecureUtil.md5(uploadFile);
        // 从数据库查询是否存在相同记录
        Files dbFiles = getFileByMd5(md5);
        if (dbFiles != null) {
            url = dbFiles.getUrl();
            //数据库已存在原文件,删除磁盘重复文件
            uploadFile.delete();
        }else {
            url = "http://localhost:8088/file/" + fileUuid;
//           url =  "https://localhost:8088/file/" + fileUuid;
            //把获取到的文件存储到磁盘目录去
        }

        //存储数据库
        Files saveFiles =  new Files();
        saveFiles.setName(originalFilename);
        saveFiles.setType(type);
        saveFiles.setSize(size/1024);
        saveFiles.setMd5(md5);
        saveFiles.setUrl(url);
        fileMapper.insert(saveFiles);

        return url;

    }

    /**
     * 文件下载接口  "http://localhost:8088/file/{fileUuid}"
     * @param fileUuid
     * @param response
     * @throws IOException
     */
    @GetMapping("/{fileUuid}")
    // throws IOException 抛出异常的一种方法
    public void downLoad(@PathVariable String fileUuid, HttpServletResponse response) throws IOException {
        //根据文件的唯一标识码获取文件
        File uploadFile = new File(fileUploadPath+fileUuid);
        ServletOutputStream os = response.getOutputStream();
        response.addHeader("Content-Disposition","attachment;filename="+ URLEncoder.encode(fileUuid,"UTF-8"));
        response.setContentType("application/octet-stream");

        // 读取文件上传的字节流
        os.write(FileUtil.readBytes(uploadFile));
        os.flush();
        os.close();

    }

    // 更新或发布物品
    @PostMapping("/update") // RequestBody->把前端传过来的json对象转为java对象
    public Result update(@RequestBody Files files ) {
        //新增或者更新
        return Result.success(fileMapper.updateById(files));
    }
    /**
     * 通过文件的md5查询文件
     * @param md5
     * @return
     */
    private  Files getFileByMd5(String md5) {
        // 查询数据是否已经存在相同图片
        QueryWrapper<Files> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("md5",md5);
        List<Files> files = fileMapper.selectList(queryWrapper);
        return files.size() == 0 ? null : files.get(0);
    }

    //删除数据
    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        Files files = fileMapper.selectById(id);
        files.setIsDelete(true);
        fileMapper.updateById(files);
        return Result.success();
    }

    //批量删除
    @PostMapping("/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        QueryWrapper<Files> queryWrapper = new QueryWrapper<>();
        queryWrapper.in("id",ids);
        List<Files> files = fileMapper.selectList(queryWrapper);
        for(Files file: files ) {
            file.setIsDelete(true);
            fileMapper.updateById(file);
        }

        return Result.success();
    }

    // 分页查询-mybatis-plus的方式
    @GetMapping("/page")
    public Result findPage(@RequestParam Integer pageNum, @RequestParam Integer pageSize,
                           @RequestParam(defaultValue = "") String name  ) {
        IPage<Files> page = new Page<>(pageNum,pageSize);
        QueryWrapper<Files> queryWrapper = new QueryWrapper<>();
        //查询未删除记录
        queryWrapper.eq("isDelete",false);
        queryWrapper.orderByDesc("id");
        if (!"".equals(name)) {
            queryWrapper.like("name",name);
        }
        IPage<Files> objectPage = new Page<>(pageNum, pageSize);

        return Result.success(fileMapper.selectPage(objectPage,queryWrapper));
    }


}
