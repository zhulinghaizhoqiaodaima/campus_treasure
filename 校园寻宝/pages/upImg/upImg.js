import {
  UpLoadImg
} from "../../api/UpLoadImg";
const app = getApp();
let Useravatar = null;
Page({
 
  data: {
    imgs: [],
    userInfo:{},
    img:null,
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
  },
// 上传图片
chooseImg (e) {
  let that = this;
  wx.chooseImage({
    // count: 1, // 默认9
    sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
    sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
    success: function (res) {
      // 返回选定照片的本地文件路径列表，tempFilePath可以作为img标签的src属性显示图片
      Useravatar = res.tempFilePaths;
      that.setData({
        img: Useravatar
      });
      wx.uploadFile({
        url: 'http://localhost:8088/file/upload', //仅为示例，非真实的接口地址
        filePath: Useravatar[0],
        name: 'file',
        formData:{
          'user': 'test'
        },
        success: function(res){
          console.log(res);
        }
      })
    }
  });

},
// 预览图片
previewImg: function (e) {
  //获取当前图片的下标
  var index = e.currentTarget.dataset.index;
  //所有图片
  var imgs = this.data.imgs;
  wx.previewImage({
    //当前显示图片
    current: imgs[index],
    //所有图片
    urls: imgs
  })
},
UpLoadImg () {
 
},
// 删除图片
deleteImg: function (e) {
  var imgs = this.data.imgs;
  var index = e.currentTarget.dataset.index;
  imgs.splice(index, 1);
  this.setData({
    imgs: imgs
  });
},
})