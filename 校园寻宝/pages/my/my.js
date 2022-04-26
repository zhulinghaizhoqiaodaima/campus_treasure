const app = getApp();
Page({
  data: {
    isShowUserName: false,
    userInfo: null,
  },
  onLoad: function () {
    if (app.globalData.userInfo) {
      this.userInfo = app.globalData.userInfo;
    }
  },
  onShow() {
    if(app.globalData.userInfo != null) {
      if( app.globalData.userInfo.avatar == "") {
        app.globalData.userInfo.avatar = "../../imgs/title.png";
      }
      this.setData({
        isShowUserName: true,
        userInfo: app.globalData.userInfo,
      })
    }
   
  },
  //退出登录
  logout() {
    this.setData({
      userInfo: null,
      isShowUserName: false
    })
    app.globalData.userInfo = null;
  },
  myLogin() {
    wx.redirectTo({
      url: '../login/login',
    })
  },
  goMyGoods() {
    wx.navigateTo({
      url: '../myGoods/myGoods',
    })
  },
  goMsg() {
    wx.navigateTo({
      url: '../myMsg/myMsg',
    })
  },
  goMyInfo() {
    wx.navigateTo({
      url: '../myInfo/myInfo',
    })
  },
  goOCR() {
    wx.navigateTo({
      url: '../OcrImg/OcrImg',
    })
  },
})