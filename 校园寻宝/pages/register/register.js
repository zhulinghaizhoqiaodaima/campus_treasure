import {
  getRegister
} from "../../api/register";
Page({
  data: {
  },
  create_zhuce(e) {
    console.log(e.detail.value)
    if(e.detail.value["nickname"] != "" &&e.detail.value["stuNum"] != "" && e.detail.value["pwd"] != "" &&
    e.detail.value["grade"] != "" && e.detail.value["phone"] != "") {
      getRegister({
        nickname: e.detail.value["nickname"],
        stuNum: e.detail.value["stuNum"],
        pwd: e.detail.value["pwd"],
        grade: e.detail.value["grade"],
        phone: e.detail.value["phone"]
      }).then((res) => {
        if(res.data == false) {
          wx.showToast({
            title: "学号已存在",
            icon: 'none',
            duration: 2000
          })
          return;
        }
        if (res.code == "200") {
          wx.showToast({
            title: "注册成功",
            duration: 2000
          })
          wx.redirectTo({
            url: '../login/login',
          })
        }
      })
      .catch((err) => {
        console.log("登录失败", err);
      });
      
    }else {
      wx.showToast({
        title: "注册选项不能为空",
        duration: 2000,
        // 弹出框的图标，不想设置图标时请给none
        icon: 'none'
      })
      return;
    }
  },
  getResult: function (res) {
    console.log(res.data);
    if (res.data == "true") {
      wx.showToast({
        title: "注册成功",
        duration: 2000
      })
      
    }

    if (res.data == "-1") {
      wx.showToast({
        title: "用户名已存在",
        icon: 'none',
        duration: 2000
      })
      setTimeout(function () {
        wx.navigateBack({
          delta: 2
        })
      }, 2000)
    }

    if (res.data == "1") {
      wx.showToast({
        title: "注册信息不为空",
        icon: 'none',
        duration: 2000
      })
      setTimeout(function () {
        wx.navigateBack({
          delta: 2
        })
      }, 2000)
    }
  },
})
