package com.zbt.springboot.controller;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.poi.excel.ExcelReader;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.zbt.springboot.common.Result;
import com.zbt.springboot.entity.Goods;
import com.zbt.springboot.service.GoodsService;
import com.zbt.springboot.service.UserService;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.List;


@RestController
@RequestMapping("/goods")
public class GoodsController {

    private final GoodsService goodsService;

    public GoodsController(GoodsService goodsService) {
        this.goodsService = goodsService;
    }
    // 发布物品
    @PostMapping("/save") // RequestBody->把前端传过来的json对象转为java对象
    public Result save(@RequestBody Goods goods ) {
        System.out.println(goods);
        System.out.println("==================================");
        //新增或者更新
        return Result.success(goodsService.saveGoods(goods));
    }
    // 获取详细物品信息
    @PostMapping("one/{goodsId}")
    public Goods GetOneGood(@PathVariable Integer goodsId) {

        return goodsService.getById(goodsId);
    }

    //更新物品
    @PostMapping("/update") // RequestBody->把前端传过来的json对象转为java对象
    public Result update(@RequestBody Goods goods ) {
        //新增或者更新
        return Result.success(goodsService.updateGoods(goods));
    }

    // 查询所有
    @GetMapping
    public List<Goods> findGoods() {

        return goodsService.list();
    }

    //删除
    @PostMapping("/{goodsId}")
    public boolean delete(@PathVariable Integer goodsId) {
        return goodsService.removeById(goodsId);
    }

    //批量删除
    @PostMapping("/batch")
    public boolean deleteBatch(@RequestBody List<Integer> goodsId) {
        return goodsService.removeBatchByIds(goodsId);
    }

    // 分页查询-mybatis-plus的方式
    @GetMapping("/page")
    public IPage<Goods> findPage(@RequestParam Integer pageNum, @RequestParam Integer pageSize,
                                 @RequestParam(defaultValue = "") String goodsName,
                                 @RequestParam(defaultValue = "") String stuNum,
                                 @RequestParam(defaultValue = "") String contactInfo,
                                 @RequestParam(defaultValue = "") String category,
                                 @RequestParam(defaultValue = "") String classification
    ) {
        IPage<Goods> page = new Page<>(pageNum,pageSize);
        QueryWrapper<Goods> queryWrapper = new QueryWrapper<>();
        // 搜查数据不能为null,即键值不能为空
        queryWrapper.like("goodsName",goodsName);
        queryWrapper.like("stuNum",stuNum);
        queryWrapper.like("contactInfo",contactInfo);
        queryWrapper.like("category",category);
        queryWrapper.like("classification",classification);
        return goodsService.page(page, queryWrapper);
    }

    @GetMapping("/my/goods")
    public Result getMyGoods( @RequestParam(defaultValue = "") String stuNum) {
        QueryWrapper<Goods> queryWrapper = new QueryWrapper<>();
        // 搜查数据不能为null,即键值不能为空
        queryWrapper.eq("stuNum",stuNum);
        return Result.success(goodsService.list(queryWrapper));
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
//        List<Goods> list = reader.readAll(Goods.class);

        // 方式2：忽略表头的中文，直接读取表的内容
        List<List<Object>> list = reader.read(1);
        List<Goods> goods = CollUtil.newArrayList();
        for (List<Object> row : list) {
            Goods goods1 = new Goods();
            goods1.setGoodsId(row.get(0).hashCode());
            goods1.setGoodsName(row.get(1).toString());
            goods1.setClassification(row.get(2).toString());
            goods1.setCategory(row.get(3).toString());
            goods1.setPlace(row.get(4).toString());
            goods1.setContactInfo(row.get(5).toString());
            goods1.setRemarks(row.get(6).toString());
            goods1.setTime(row.get(7).toString());
//            goods1.setCardId(row.get(8).toString());
            goods1.setGoodsImg(row.get(8).toString());
            goods.add(goods1);
        }

        goodsService.saveBatch(goods);
        return true;
    }


    /**
     * 导出接口
     */
    @GetMapping("/export")
    public void export(HttpServletResponse response) throws Exception {
        // 从数据库查询出所有的数据
        List<Goods> list = goodsService.list();
        // 通过工具类创建writer 写出到磁盘路径
//        ExcelWriter writer = ExcelUtil.getWriter(filesUploadPath + "/用户信息.xlsx");
        // 在内存操作，写出到浏览器
        ExcelWriter writer = ExcelUtil.getWriter(true);
        //自定义标题别名
        writer.addHeaderAlias("goodsId", "id");
        writer.addHeaderAlias("goodsName", "物品名称");
        writer.addHeaderAlias("stuNum", "学号");
        writer.addHeaderAlias("classification", "分类");
        writer.addHeaderAlias("category", "类别");
        writer.addHeaderAlias("place", "地点");
        writer.addHeaderAlias("contactInfo", "联系方式");
        writer.addHeaderAlias("remarks", "备注");
        writer.addHeaderAlias("time", "时间");
        writer.addHeaderAlias("cardId", "卡号");
        writer.addHeaderAlias("goodsImg", "物品图片");

        // 一次性写出list内的对象到excel，使用默认样式，强制输出标题
        writer.write(list, true);

        // 设置浏览器响应的格式
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;charset=utf-8");
        String fileName = URLEncoder.encode("物品信息", "UTF-8");
        response.setHeader("Content-Disposition", "attachment;filename=" + fileName + ".xlsx");

        ServletOutputStream out = response.getOutputStream();
        writer.flush(out, true);
        out.close();
        writer.close();

    }
}
