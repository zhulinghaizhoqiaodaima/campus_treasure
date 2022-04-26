import {
  saveGoodsInfo
} from "../../api/saveGoodsInfo";
var app = getApp();
Page({
  data: {
    imgs: [],
    goodsStateArr: ['拾取', '丢失'],
    category: ['书籍', '磁卡', '钥匙', '手机', '钱包', '其他'],
    categoryArr: [{
      id: 0,
      name: '书籍'
    }, {
      id: 1,
      name: '磁卡'
    }, {
      id: 2,
      name: '钥匙'
    }, {
      id: 3,
      name: '手机'
    }, {
      id: 4,
      name: '钱包'
    }, {
      id: 5,
      name: '其他'
    }],
    goodsInfo:{
        goodsName: null,
        stuNum:null,
        classification: null,
        category: null,
        place: null,
        contactInfo: null,
        remarks: null,
        goodsImg:null,
        time:null,
        cardId:null,
    }
  },
  onShow() {
    if(app.globalData.userInfo != null) {
      this.data.goodsInfo.stuNum = app.globalData.userInfo.stuNum;
    }else{
      wx.showToast({
        title: "未登录请授权登录",
        duration: 4000,
        // 弹出框的图标，不想设置图标时请给none
        icon: 'none'
      })
    }

  },
  // 选择地址
  //移动选点
  onChangeAddress(e) {
    let that = this;
    wx.showLoading({
      title: '加载中',
    })
    setTimeout(function () {
      wx.hideLoading()
    }, 2000)
    wx.chooseLocation({
      success: function (res) {
        that.setData({
          chooseAddress: res.name
        });
        that.data.goodsInfo.place =res.name;
      },
      fail: function (err) {
        console.log(err)
      }
    });
    
  },
  // 上传图片
  chooseImg (e) {
    let that = this;
    wx.chooseImage({
      sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
      sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
      success: function (res) {
        // 返回选定照片的本地文件路径列表，tempFilePath可以作为img标签的src属性显示图片
        that.data.goodsInfo.goodsImg = res.tempFilePaths[0];
        wx.uploadFile({
          url: 'http://localhost:8088/file/upload', //仅为示例，非真实的接口地址
          filePath:that.data.goodsInfo.goodsImg,
          name: 'file',
          formData:{
            'user': 'test'
          },
          success: function(res){
            that.setData({
              goodsImg: that.data.goodsInfo.goodsImg,
            })
            that.data.goodsInfo.goodsImg = res.data;
          }
        })
      }
    });
  
  },
  // 获取标题
  getTitle(e) {
    this.data.goodsInfo.goodsName = e.detail.value;
  },
  // 获得物品状态
  bindGoodsChange(e) {
    let index =  parseInt(e.detail.value);
    this.data.goodsInfo.classification = this.data.goodsStateArr[index];
    console.log('picker发送选择改变，携带值为',index);
    // this.array[e.detail.value]
    this.setData({
      index: e.detail.value
    })
  },
  //物品分类
  bindGoodsType(e) {
    let index =  parseInt(e.detail.value);
    console.log(this.data.category[index]);
    this.data.goodsInfo.category =this.data.category[index];
    if(this.data.goodsInfo.category == "磁卡") {
      wx.showModal({
        title: '校园卡',
        content: '自动匹配失主',
      }).then(res=>{
          if (res.confirm) {
            console.log('确定')
            let campusId = true;
            wx.navigateTo({
              url: '../OcrImg/OcrImg?campusId=' + campusId,
            })
            this.setData({
              goodsName:"",
              index:null,
              categoryIndex:null,
            })
          } else {
            console.log('取消')
          }
      })
      ;
    }
    console.log('picker发送选择改变，携带值为', index);
    
    this.setData({
      categoryIndex: e.detail.value
    })
  },
  // 获取联系方式
  getContact(e) {
    // console.log(e.detail.value);
    this.data.goodsInfo.contactInfo = e.detail.value;

  },
  // 获取信息备注
  getRemark(e) {
    // console.log(e.detail.value);
    this.data.goodsInfo.remarks = e.detail.value;

  },

  ConfirmInfo() {
    // console.log(this.data.goodsInfo);
    if(this.data.goodsInfo.goodsImg == null) {
      this.data.goodsInfo.goodsImg =
      "../../imgs/title.png";
    }
    this.setData({
      goodsName:"",
      index:null,
      categoryIndex:null,
      chooseAddress:"",
      contactInfo:"",
      remarks:"",
      goodsImg:"",
      remarks:""
    })
    if( this.data.goodsInfo.goodsName == null) {
      wx.showToast({
        title: "标题不能为空",
        duration: 4000,
        // 弹出框的图标，不想设置图标时请给none
        icon: 'error'
      })
      return;
    }
    if( this.data.goodsInfo.classification == null) {
      wx.showToast({
        title: "物品状态不能为空",
        duration: 4000,
        // 弹出框的图标，不想设置图标时请给none
        icon: 'error'
      })
      return;
    }
    if( this.data.goodsInfo.category == null) {
      wx.showToast({
        title: "物品分类不能为空",
        duration: 4000,
        // 弹出框的图标，不想设置图标时请给none
        icon: 'error'
      })
      return;
    }
    if( this.data.goodsInfo.place == null) {
      wx.showToast({
        title: "拾取或丢失地点不能为空",
        duration: 4000,
        // 弹出框的图标，不想设置图标时请给none
        icon: 'error'
      })
      return;
    }
    if( this.data.goodsInfo.contactInfo == null) {
      wx.showToast({
        title: "联系方式不能为空",
        duration: 4000,
        // 弹出框的图标，不想设置图标时请给none
        icon: 'error'
      })
      return;
    }


    this.data.goodsInfo = {
      goodsName: this.data.goodsInfo.goodsName,
      stuNum: this.data.goodsInfo.stuNum,
      classification: this.data.goodsInfo.classification,
      category: this.data.goodsInfo.category,
      place: this.data.goodsInfo.place,
      contactInfo: this.data.goodsInfo.contactInfo,
      remarks: this.data.goodsInfo.remarks,
      goodsImg:this.data.goodsInfo.goodsImg,
      time:this.data.goodsInfo.time,
      cardId:this.data.goodsInfo.cardId,
    }
    saveGoodsInfo(this.data.goodsInfo).then((res) => {
      if (res) {
        console.log(res);
        wx.showToast({
          title: "发布成功",
          duration: 3000,
          success: function () {
            setTimeout(function() {
              wx.switchTab({
                url: '../home/home',
              })
            }, 2000);
          }
        })
      }
    })
    .catch((err) => {
      console.log(err);

    });
  }


})