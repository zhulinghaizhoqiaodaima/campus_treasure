<template>
  <div class="wrapper">
    <div style="margin: 200px auto; background-color: #fff; width: 350px; height: 300px; padding: 20px; border-radius: 10px">
      <el-form  :model="user" :rules="rules"  ref="userForm">
        <el-form-item prop="username">
          <el-input  size="medium" style="margin: 10px 0" prefix-icon="el-icon-user" v-model="user.stuNum">
          </el-input>
        </el-form-item>        
        <el-form-item prop="password">
          <el-input  size="medium" style="margin: 10px 0" prefix-icon="el-icon-lock" show-password v-model="user.password">
          </el-input>
        </el-form-item>
        <el-form-item style="margin: 10px 0; text-align: right">
        <el-button type="primary" size="small"  autocomplete="off"  @click="submitForm('userForm')" >登录</el-button>
        </el-form-item>
      </el-form>
      
      
    </div>
  </div>
</template>

<script>
export default {
  name: "Login",
  data() {
    return {
      user: {
        stuNum:'',
        password:''
      },
      rules:{
        stuNum: [
          { required: true,message: '请输入用户名',trigger: 'blur'},
          {min:1, max: 20, message: "长度在1到5个字符",trigger: 'blur'},
        ],
        password: [
          { required: true,message: '请输入密码',trigger: 'blur'},
          {min:3, max: 16, message: "长度在3到16个字符",trigger: 'blur'},
        ]
      }
    }
  },
  methods: {
    login() {
      console.log(this.user);
      this.request.post("/user/loginAdmin",this.user).then(res=>{
        console.log(res);
        if(res.code == '200') {
          if(res.data.admin) {
              this.$message({
            message: '登录成功',
            type: 'success'
          });
         
          localStorage.setItem("user",JSON.stringify(res.data)); // 存储用户信息存储到浏览器
    
           
            this.$router.push("/");
          }else{
            this.$message({
            message: '不是管理员账户',
            type: 'error'
          });
          }
        }else{
           this.$message.error(res.msg)
        }
      })
    },
    submitForm(formName) { // 表单校验
      this.$refs[formName].validate((valid) => {
        if (valid) {  // 合法
          this.login()
        } else {
          console.log('error submit!!');
         this.$message({
          message: '账户或密码不符合规则',
          type: 'warning'
        });
          return false;
        }
      });
    },
    resetForm(formName) {
      this.$refs[formName].resetFields();
    }
  }
}
</script>

<style>
  .wrapper {
    height: 100vh;
    background-image: linear-gradient(to bottom right, #FC466B , #3F5EFB);
    overflow: hidden;
  }
</style>
