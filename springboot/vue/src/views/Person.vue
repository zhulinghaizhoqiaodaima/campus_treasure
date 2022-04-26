<template>
  <el-card class="containerPerson">
      <el-form :model="form" label-width="80px" size="small">
        <el-upload 
          class="avatar-uploader"
          action="http://localhost:8088/file/upload"
          :show-file-list="false"
          :on-success="handleAvatarSuccess">
          <img v-if="form.avatar" :src="form.avatar" class="avatar">
          <i v-else class="el-icon-plus avatar-uploader-icon"></i>
        </el-upload>
        <el-form-item label="用户名">
          <el-input v-model="form.nickname" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="密码">
          <el-input v-model="form.pwd" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="电话">
          <el-input v-model="form.phone" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="年级">
          <el-input v-model="form.grade" autocomplete="off"></el-input>
        </el-form-item>
         <el-form-item label="头像">
          <el-input v-model="form.avatar" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item>
            <el-button type="primary" @click="save">确 定</el-button>
        </el-form-item>
      </el-form>
  </el-card>
</template>

<script>
export default {
    name:"Person",
    data(){
        return {
            form:{},
            user:localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {}
        }
    },
    created(){
      this.getUser().then(res=>{
        console.log(res);
        this.form = res;
      });
     

    },
    methods:{ 
       async getUser() {
        return (await this.request.delete("/user/personMsg/"+this.user.stuNum)).data;
        },
        save() {
            this.request.post("/user/save", this.form).then(res => {
                if (res.data) {
                   this.$message.success("保存成功");
                  
                  //触发父级更新User的方法
                  this.$emit("refreshUser");

                   //更新浏览器存储的用户信息,确保浏览器信息是正确的
                   this.getUser().then(res=>{
                    res.token = JSON.parse(localStorage.getItem("user")).token;
                    localStorage.setItem("user",JSON.stringify(res));
                   });
                } else {
                    this.$message.error("保存失败")
                }
            })
        },
        handleAvatarSuccess(res) {
          this.form.avatar = res;
        },
      // beforeAvatarUpload(file) {
      //   const isJPG = file.type === 'image/jpeg';
      //   const isLt2M = file.size / 1024 / 1024 < 2;

      //   if (!isJPG) {
      //     this.$message.error('上传头像图片只能是 JPG 格式!');
      //   }
      //   if (!isLt2M) {
      //     this.$message.error('上传头像图片大小不能超过 2MB!');
      //   }
      //   return isJPG && isLt2M;
      // },
      
    }

}
</script>

<style>
.containerPerson{
    width: 500px;
    padding: 20px;
    border: 1px solid #ccc;
  }
  
  .avatar-uploader {
    text-align: center;
    padding-bottom: 10px;
  }

 .avatar-uploader .el-upload {
    border: 1px dashed #d9d9d9;
    border-radius: 6px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
  }
  .avatar-uploader .el-upload:hover {
    border-color: #409EFF;
  }
  .avatar-uploader-icon {
    font-size: 28px;
    color: #8c939d;
    width: 140px;
    height: 140px;
    line-height: 140px;
    text-align: center;
  }
  .avatar {
    width: 140px;
    height: 140px;
    display: block;
  }
</style>