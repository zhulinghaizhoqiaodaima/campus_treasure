import {
  getPersonInfo
} from "../../api/getPersonInfo";
import {
  getUserSave
} from "../../api/getUserSave";
const app = getApp()
let stuNumOcr = null;
Page({
  data: {
    imageSrc: "",
    showView: false
  },
  onLoad(opt) {
    if(opt.campusId) {
      this.chooseImage();
    }
  },
  chooseImage() {
    var that = this;
    wx.chooseImage({
      count: 1,
      success: function (e) {
        console.log(e.tempFilePaths[0])
        that.setData({
          imageSrc: e.tempFilePaths[0]
        })
        wx.showToast({
          title: '数据加载中',
          icon: 'loading',
          duration: 2000
        });
        wx.getFileSystemManager().readFile({
          filePath: e.tempFilePaths[0], //选择图片返回的相对路径
          encoding: 'base64', //编码格式
          success: res => {
            console.log("图片转码回调");
            console.log(res);
            wx.request({
              url: 'https://lysbwdxs.market.alicloudapi.com/ocrservice/document',
              data:{
                "img":res.data
              },
              header: {
                "Authorization": "APPCODE 4bce70e7eda54e2ca5b41ba1eb7eab89", //阿里云ocr名片识别code
                "Content-Type": "application/json; charset=UTF-8"
              },
              method: 'POST',
              dataType: 'json',
              responseType: 'text',
              success: function (res) {
                console.log(res.data.prism_wordsInfo);
                let OcrInfo = res.data.prism_wordsInfo;
                let arr = [];
                let reg = new RegExp("学号：");
                OcrInfo.forEach(item => {
                  if(item.word.match(reg)) {
                    arr.push(item.word.match(reg));
                  }
                });
                console.log(arr);
                stuNumOcr = arr[0].input.replace("学号：","");
                if(arr.length === 1) {
                  that.getUserInfo(stuNumOcr);
                }else{
                  wx.showToast({
                    title: "识别失败",
                    duration: 4000,
                    icon: 'error'
                  })
                  this.setData({
                    name:"识别错误",
                    phone: "识别错误",
                    showView: true,
                    stuNum:stuNumOcr,
                  })
                }
                if (200 == res.statusCode) {
                } else {
                  wx.showModal({
                    title: '提示信息',
                    content: '你选择的图片不符合规格，请重新上传',
                    showCancel: false,
                    confirmText: '确定',
                    success: function (res) {
                      console.log("点击了确定", res)
                      that.setData({
                        imageSrc: "",
                        showView: false,
                        name: res.data.name,
                        company: res.data.company,
                        department: res.data.department,
                        title: res.data.title,
                        tel_cell: res.data.tel_cell,
                        tel_work: res.data.tel_work,
                        addr: res.data.addr,
                        email: res.data.email
                      })
                    }
                  })
                }
              }
            })
          },
          fail: res=>{
            console.log(res+"报错");
          }
        })
      }
    })
  },
  getUserInfo(stuNum) {
    getPersonInfo("/user/getPerson/"+stuNum,{
    }).then((res) => {
        if(res.data == null) {
          wx.showToast({
            title: "该用户未注册",
            duration: 4000,
            icon: 'error'
          });
          this.setData({
            name:"失主未注册",
            phone: "失主未注册",
            showView: true,
            stuNum:stuNum,
          })
          return;
        }else {
          wx.showToast({
            title: "匹配成功",
            duration: 4000,
            icon: 'success'
          })
          this.setData({
            name: res.data.nickname,
            phone: res.data.phone,
            showView: true,
            stuNum:stuNum,
          })
          this.SavePerson(res.data);
        }
      
    })
    .catch((err) => {
      console.log("用户信息获取失败", err);
      wx.showToast({
        title: "用户信息获取失败",
        duration: 4000,
        icon: 'error'
      })
    });
  },
  SavePerson(res){
    let personInfo = app.globalData.userInfo.nickname +"," + app.globalData.userInfo.phone;
    console.log(personInfo);
    console.log(res);
    getUserSave({
      nickname:res.nickname,
      avatar:res.avatar,
      grade:res.grade,
      phone:res.phone,
      pwd:res.pwd,
      stuNum:res.stuNum,
      iscontactInfo:personInfo,
    }).then((res) => {
      if (res) {
        wx.showToast({
          title: "已成功通知失主",
          duration: 4000
        })
      }
    })
    .catch((err) => {
      console.log(err);
    });
  }
})