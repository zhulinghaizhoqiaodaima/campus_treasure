
const app = getApp();
Page({
  data: {

  },
  //加载
  onLoad(options) {
    this.renderInfo();
  },
  renderInfo() {
    console.log(app.globalData.userInfo);
   if( app.globalData.userInfo.iscontactInfo == null  ) {
      this.setData({
        isShowInfo:false,
      })
   }else {
     console.log( app.globalData.userInfo.iscontactInfo);
     let arr =  app.globalData.userInfo.iscontactInfo.split(",");
    this.setData({
      isShowInfo:true,
      name:arr[0],
      phone:arr[1]

    })
   }
 
  }
})