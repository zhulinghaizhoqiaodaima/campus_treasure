<template>
  <div>
      <div style="margin: 10px 0">
      <el-input style="width: 200px" placeholder="请输入文件名称" suffix-icon="el-icon-search" v-model="name"></el-input>
      <el-button class="ml-5" type="primary" @click="load">搜索</el-button>
      <el-button type="warning" @click="reset">重置</el-button>
    </div>
    <div style="margin: 10px 0">
     <el-upload  action="http://localhost:8088/file/upload" :show-file-list="false" :on-success="handleFileUpSuccess" style="display: inline-block">
        <el-button type="primary" class="ml-5">上传文件 <i class="el-icon-top"></i></el-button>
      </el-upload>
      <el-popconfirm
          class="ml-5"
          confirm-button-text='确定'
          cancel-button-text='我再想想'
          icon="el-icon-info"
          icon-color="red"
          title="您确定批量删除这些数据吗？"
          @confirm="delBatch"
      >
        <el-button type="danger" slot="reference">批量删除 <i class="el-icon-remove-outline"></i></el-button>
      </el-popconfirm>
    </div>
    <el-table
      :data="tableData"
      border
      stripe
      :header-cell-class-name="'headerBg'"
      @selection-change="handleSelectionChange"
    >

      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column prop="id" label="ID" width="80"></el-table-column>
      <el-table-column
        prop="name"
        label="文件名称"
      ></el-table-column>
      <el-table-column
        prop="type"
        label="文件类型"
      ></el-table-column>
      <el-table-column prop="size" label="文件大小(KB)"></el-table-column>
      <el-table-column label="下载">
        <template slot-scope="scope">
           <el-button type="success" @click="getImg(scope.row)">下载</el-button>
        </template>
      </el-table-column>
      <el-table-column label="启用">
        <template slot-scope="scope">
            <el-switch v-model="scope.row.enable" active-color= "#13ce66" inactive-color="#ccc" 
            @change="changeEnable(scope.row)"></el-switch>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="200" align="center">
        <template slot-scope="scope">
          <el-popconfirm
            class="ml-5"
            confirm-button-text="确定"
            cancel-button-text="我再想想"
            icon="el-icon-info"
            icon-color="red"
            title="您确定删除吗？"
            @confirm="del(scope.row.id)"
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
          :total="total">
      </el-pagination>
    </div>
  </div>
</template>

<script>
export default {
  name: "Files",
  data() {
    return {
      tableData: [],
      total: 0,
      pageNum: 1,
      pageSize: 10,
      name: "",
      type:null,
      size:null,
      url:null,
      multipleSelection:[],
      

    };
  },
  created() {
    this.load();
  },
  methods: {
    load() {
      this.request
        .get("/file/page", {
          params: {
            pageNum: this.pageNum,
            pageSize: this.pageSize,
            name:this.name,
          },
        })
        .then((res) => {
          console.log(res);
          this.tableData = res.data.records;
          console.log(this.tableData);
          this.total = res.data.total;
        });
    },
    del(id) {
      this.request.delete("/file/" + id).then((res) => {
        if (res.code === "200") {
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
      let ids = this.multipleSelection.map((v) => v.id); // [{}, {}, {}] => [1,2,3]
      this.request.post("/file/batch", ids).then((res) => {
        if (res) {
          this.$message.success("批量删除成功");
          this.load();
        } else {
          this.$message.error("批量删除失败");
        }
      });
    },
    reset() {
      this.name = "";
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
    handleFileUpSuccess(res) {
        console.log(res);
        this.load();
    },
  getImg(data) {
     window.open(data.url)
    console.log(data);
    },
    changeEnable(row) {
    this.request.post("/file/update", row).then((res) => {
        if (res.code == 200) {
            this.$message.success("更新成功");
        }else {
          this.$message.error("更新失败");
        }
    });
  },
  fileUpload() {
    
  }
    
  }
};
</script>

<style></style>
