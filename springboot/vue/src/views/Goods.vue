<template>
  <div>
    <div style="margin: 10px 0">
      <el-input
        style="width: 200px"
        placeholder="请输入物品名称"
        suffix-icon="el-icon-search"
        v-model="goodsName"
      ></el-input>
      <el-input
        style="width: 200px"
        placeholder="请输入联系方式"
        suffix-icon="el-icon-search"
        class="ml-5"
        v-model="contactInfo"
      ></el-input>
      <el-input
        style="width: 200px"
        placeholder="请输入学号"
        suffix-icon="el-icon-position"
        class="ml-5"
        v-model="stuNum"
      ></el-input>
      <el-button class="ml-5" type="primary" @click="load">搜索</el-button>
      <el-button type="warning" @click="reset">重置</el-button>
    </div>

    <div style="margin: 10px 0">
      <el-button type="primary" @click="handleAdd"
        >新增 <i class="el-icon-circle-plus-outline"></i
      ></el-button>
      <el-popconfirm
        class="ml-5"
        confirm-button-text="确定"
        cancel-button-text="我再想想"
        icon="el-icon-info"
        icon-color="red"
        title="您确定批量删除这些数据吗？"
        @confirm="delBatch"
      >
        <el-button type="danger" slot="reference"
          >批量删除 <i class="el-icon-remove-outline"></i
        ></el-button>
      </el-popconfirm>

      <el-upload
        action="http://localhost:8088/goods/import"
        :show-file-list="false"
        accept="xlsx"
        :on-success="handleExcelImportSuccess"
        style="display: inline-block"
      >
        <el-button type="primary" class="ml-5"
          >导入 <i class="el-icon-bottom"></i
        ></el-button>
      </el-upload>
      <el-button type="primary" @click="exp" class="ml-5"
        >导出 <i class="el-icon-top"></i
      ></el-button>
    </div>

    <el-table
      :data="tableData"
      border
      stripe
      :header-cell-class-name="'headerBg'"
      @selection-change="handleSelectionChange"
    >
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column prop="goodsId" label="物品ID"></el-table-column>
      <el-table-column prop="goodsName" label="物品名称"></el-table-column>
      <el-table-column prop="stuNum" label="发布人学号"></el-table-column>
      <el-table-column prop="classification" label="分类"></el-table-column>
      <el-table-column prop="category" label="类别"></el-table-column>
      <el-table-column prop="place" label="地点"></el-table-column>
      <el-table-column prop="contactInfo" label="联系方式"></el-table-column>
      <el-table-column
        prop="remarks"
        label="备注"
        width="200"
      ></el-table-column>
      <el-table-column prop="time" label="时间"></el-table-column>
      <el-table-column prop="cardId" label="卡号"></el-table-column>
      <el-table-column prop="goodsImg" label="物品图片"></el-table-column>
      <el-table-column label="操作" width="200" align="center">
        <template slot-scope="scope">
          <el-button type="success" @click="handleEdit(scope.row)"
            >编辑 <i class="el-icon-edit"></i
          ></el-button>
          <el-popconfirm
            class="ml-5"
            confirm-button-text="确定"
            cancel-button-text="我再想想"
            icon="el-icon-info"
            icon-color="red"
            title="您确定删除吗？"
            @confirm="del(scope.row.goodsId)"
          >
            <el-button type="danger" slot="reference"
              >删除 <i class="el-icon-remove-outline"></i
            ></el-button>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>

    <div style="padding: 10px 0">
      <el-pagination
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
        :current-page="pageNum"
        :page-sizes="[2, 5, 10, 20]"
        :page-size="pageSize"
        layout="total, sizes, prev, pager, next, jumper"
        :total="total"
      >
      </el-pagination>
    </div>

    <el-dialog title="物品信息" :visible.sync="dialogFormVisible" width="30%">
      <el-form label-width="80px" size="small">
        <!-- <el-form-item label="卡号">
          <el-input v-model="form.goodsId" autocomplete="off"></el-input>
        </el-form-item> -->
        <el-form-item label="物品名称">
          <el-input v-model="form.goodsName" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="发布人学号">
          <el-input
            v-model="form.stuNum"
            autocomplete="off"
          ></el-input>
        </el-form-item>
        <el-form-item label="分类">
          <el-input v-model="form.classification" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="类别">
          <el-input v-model="form.category" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="地点">
          <el-input
            v-model="form.place"
            type="textarea"
            autocomplete="off"
          ></el-input>
        </el-form-item>
        <el-form-item label="联系方式">
          <el-input v-model="form.contactInfo" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="备注信息">
          <el-input
            v-model="form.remarks"
            type="textarea"
            autocomplete="off"
          ></el-input>
        </el-form-item>
        <el-form-item label="拾取/丢失时间">
          <el-input v-model="form.time" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="物品图片">
          <el-input v-model="form.goodsImg" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="save(isUpdate)">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: "Goods",
  data() {
    return {
      tableData: [],
      total: 0,
      pageNum: 1,
      pageSize: 10,
      goodsId: "",
      goodsName: "",
      stuNum: "",
      classification: "",
      category: "",
      place: "",
      contactInfo: "",
      remarks: "",
      goodsImg: "",
      cardId: "",
      time: "",
      form: {},
      dialogFormVisible: false,
      multipleSelection: [],
      isUpdate: false,
    };
  },
  created() {
    this.load();
  },
  methods: {
    load() {
      this.request
        .get("/goods/page", {
          params: {
            pageNum: this.pageNum,
            pageSize: this.pageSize,
            goodsId: this.goodsId,
            goodsName: this.goodsName,
            stuNum: this.stuNum,
            contactInfo: this.contactInfo,
            place: this.place,
            remarks: this.remarks,
            time: this.time,
            goodsImg: this.goodsImg,
          },
        })
        .then((res) => {
          console.log(res);
          // console.log("hhhh");
          this.tableData = res.records;
          this.total = res.total;
        });
    },
    save(isUpdate) {
      if (isUpdate) {
        console.log(this.form);
        this.request.post("/goods/update", this.form).then((res) => {
          if (res.code =="200") {
            console.log(res);
            this.$message.success("保存成功");
            this.dialogFormVisible = false;
            this.load();
          } else {
            this.$message.error("保存失败");
          }
        });
      } else {
        this.request.post("/goods/save", this.form).then((res) => {
          if (res.code =="200") {
            console.log(res);
            this.$message.success("保存成功");
            this.dialogFormVisible = false;
            this.load();
          } else {
            this.$message.error("保存失败");
          }
        });
      }
    },
    handleAdd() {
      this.dialogFormVisible = true;
      this.form = {};
      this.isUpdate = false;
    },
    handleEdit(row) {
      this.form = row;
      this.dialogFormVisible = true;
      this.isUpdate = true;
    },
    del(goodsId) {
      console.log(goodsId);
      this.request.post("/goods/" +goodsId).then((res) => {
        if (res) {
          this.$message.success("删除成功");
          this.load();
        } else {
          this.$message.error("删除失败");
        }
      });
    },
    handleSelectionChange(val) {
      console.log(val);
      this.multipleSelection = val;
    },
    delBatch() {
      let goodsIds = this.multipleSelection.map((v) => v.goodsId); // [{}, {}, {}] => [1,2,3]
      this.request.post("/goods/batch", goodsIds).then((res) => {
        if (res) {
          this.$message.success("批量删除成功");
          this.load();
        } else {
          this.$message.error("批量删除失败");
        }
      });
    },
    reset() {
      (this.goodsName = ""),
        (this.goodsId = ""),
        (this.classification = ""),
        (this.category = ""),
        (this.contactInfo = ""),
        (this.place = ""),
        (this.remarks = ""),
        (this.time = ""),
        (this.goodsImg = "");
      this.load();
    },
    handleSizeChange(pageSize) {
      console.log(pageSize);
      this.pageSize = pageSize;
      this.load();
    },
    handleCurrentChange(pageNum) {
      console.log(pageNum);
      this.pageNum = pageNum;
      this.load();
    },
    exp() {
      window.open("http://localhost:8088/goods/export");
    },
    handleExcelImportSuccess() {
      this.$message.success("导入成功");
      this.load();
    },
  },
};
</script>

<style>
.headerBg {
  background: #eee !important;
}
</style>
