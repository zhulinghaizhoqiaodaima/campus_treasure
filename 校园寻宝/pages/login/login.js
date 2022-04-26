import {
  getLogin
} from "../../api/login";
const app = getApp();
Page({
  create_login: function (e) {
    console.log(e.detail.value)
    getLogin({
        stuNum: e.detail.value["username"],
        password: e.detail.value["password"]
      }).then((res) => {
        app.globalData.userInfo = res.data;
        console.log(res.data);
        if (res.code == "200") {
          wx.showToast({
            title: "登录成功",
            duration: 2000
          })
          wx.switchTab({
            url: '../home/home',
          })
        } else {
          wx.showToast({
            title: res.msg,
            icon: 'none',
            duration: 3000
          })
        }
      })
      .catch((err) => {
        console.log("登录失败", err);

      });
  },
  register: function (res) {
    wx.navigateTo({
      url: '../register/register',
    })
  }
})