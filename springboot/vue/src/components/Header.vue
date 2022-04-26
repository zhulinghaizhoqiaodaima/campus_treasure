<template>
  <div style="line-height: 60px; display: flex">
    <div style="flex: 1">
      <span
        :class="collapseBtnClass"
        style="cursor: pointer; font-size: 18px"
        @click="collapse"
      ></span>

      <el-breadcrumb
        separator="/"
        style="display: inline-block; margin-left: 10px"
      >
        <el-breadcrumb-item :to="'/'">首页</el-breadcrumb-item>
        <el-breadcrumb-item>{{ currentPathName }}</el-breadcrumb-item>
      </el-breadcrumb>
    </div>

    <el-dropdown style="width: 100px; cursor: pointer">
      <div style="display: inline-block">
        <img
          :src="user.avatar "
          alt=""
          style="
            width: 40px;
            height: 40px;
            border-radius: 50%;
            position: relative;
            top: 14px;
            right: 5px;

          "
        />
        <span style="font-size: 12px;font-weight:bolder;">{{ user.nickname }}</span
        ><i class="el-icon-arrow-down" style="margin-left: 5px"></i>
      </div>
      <el-dropdown-menu
        slot="dropdown"
        style="width: 100px; text-align: center"
      >
        <el-dropdown-item style="font-size: 14px; padding: 5px 0">
          <router-link to="/person">个人信息</router-link>
        </el-dropdown-item>
        <el-dropdown-item style="font-size: 14px; padding: 5px 0">
          <el-dropdown-item style="text-decoration: none " @click.native="logout">退出</el-dropdown-item>
        </el-dropdown-item>
      </el-dropdown-menu>
    </el-dropdown>
  </div>
</template>

<script>
export default {
  name: "Header",
  data() {
    return {};
  },
  props: {
    collapseBtnClass: String,
    collapse: Boolean,
    user: Object || {},
  },
  methods: {
    logout() {
      console.log("执行退出");
      this.$router.push("/loginAdmin");
      localStorage.removeItem("user");
      
      this.$message.success("退出成功");
    },
  },
  computed: {
    currentPathName() {
      return this.$store.state.currentPathName; //需要监听的数据
    },
  },
};
</script>

<style scoped>
.el-icon-arrow-down {
  position: absolute;
  top: 70%;
  right: 34%;

}
</style>
