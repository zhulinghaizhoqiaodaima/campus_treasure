import {
  getUserSave
} from "../../api/getUserSave";
const app = getApp();
Page({

  /**
   * 页面的初始数据
   */
  data: {
    userInfo:{},
    grade:null,
    nickname:null,
    phone:null,
    avatar:null,
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    console.log(app.globalData.userInfo+"hhhh");
    if (app.globalData.userInfo) {
      this.userInfo = app.globalData.userInfo;
      console.log(this.userInfo);
      if( app.globalData.userInfo.avatar == null) {
        this.userInfo.avatar = "../../imgs/title.png";
      }

      this.setData({
        userInfo: this.userInfo,
      })
  }
  },
    // 获取昵称
    getNickname(e) {
      console.log(e.detail.value);
     if(e.detail.value != null) {
      this.data.nickname = e.detail.value;
     }
    },
    // 获取年级
    getGrade(e) {
      if(e.detail.value != null) {
        this.data.grade = e.detail.value;
       }
      console.log(e.detail.value);
    },
    // 获取联系方式
    getContact(e) {
      console.log(e);
      if(e.detail.value != null) {
        this.data.phone = e.detail.value;
       }
      // this.data.phone = e.datail.value;
  
    },
    InfoChange () {
      console.log(this.userInfo);
      getUserSave({
        stuNum: this.userInfo.stuNum ,
        pwd: this.userInfo.password,
        nickname: this.data.nickname == null ? this.userInfo.nickname :this.data.nickname,
        grade:this.data.grade == null ? this.userInfo.grade :this.data.grade,
        phone: this.data.phone == null ? this.userInfo.phone :this.data.phone,
        avatar: this.data.avatar == null ? this.userInfo.avatar :this.data.avatar,
      }).then((res) => {
        if (res) {
          app.globalData.userInfo = res.data;
          console.log(res);
          wx.showToast({
            title: "修改成功",
            duration: 3000
          })
        }
      })
      .catch((err) => {
        console.log(err);
  
      });
    },
    chooseImg (e) {
      let that = this;
      wx.chooseImage({
        
        // count: 1, // 默认9
        sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
        sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
        success: function (res) {
          // 返回选定照片的本地文件路径列表，tempFilePath可以作为img标签的src属性显示图片
          that.userInfo.avatar = res.tempFilePaths[0];
          wx.uploadFile({
            url: 'http://localhost:8088/file/upload', //仅为示例，非真实的接口地址
            filePath: that.userInfo.avatar,
            name: 'file',
            formData:{
              'user': 'test'
            },
            success: function(res){
              console.log(res);
              console.log(that.userInfo.avatar);
              that.userInfo.avatar = res.data;
              that.setData({
                userInfo: that.userInfo,
              })
            }
          })
        }
      });
    
    },
})