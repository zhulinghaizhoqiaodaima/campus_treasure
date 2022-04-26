import {
  getMyGoods
} from "../../api/getMyGoods";
import {
  deleteGoods
} from "../../api/deleteGoods";
const app = getApp();
Page({
  data: {
    Tab: 0,
    leftActiveNum: 0,
    options: null,
    selectList: [{
        name: '分类',
        list: [{
            id: 1,
            content: '拾取'
          },
          {
            id: 2,
            content: '丢失'
          },
        ]
      },

    ],
    showIndex: -1,
    scrollHeight: 0, // scroll-view高度
    startX: 0, // 开始X坐标
    startY: 0, // 开始Y坐标
    list: [],


  },
  onLoad: function () {
    let that = this;
    // 动态获取屏幕高度
    that.setData({
      scrollHeight: wx.getSystemInfoSync().screenHeight
    })
    this.userInfo = app.globalData.userInfo;
    this.GoodsInfo();
  },
  GoodsInfo() {
    getMyGoods({}).then((res) => {
        this.GoodsList(res);
      })
      .catch((err) => {
        console.log("物品数据获取失败", err);
      });
  },
  GoodsList(res) {
    let stuNum = "123"
    let arr = [];
    res.forEach(item => {
      if (item.stuNum == stuNum) {
      
        arr.push(item);
      }
    });
    this.data.list = arr;
    console.log(arr);
    this.setData({
      Goods: arr
    })
  },
  goodsDetails(e) {
    console.log(e.currentTarget.dataset.id);
    wx.navigateTo({
      url: '../goodsDetails/goodsDetails?id=' + e.currentTarget.dataset.id
    })
  },

  // 手指触摸动作开始
  touchStart(e) {
    //开始触摸时 重置所有删除
    this.data.list.forEach(item=>{
      if (item.isTouchMove) {
        item.isTouchMove = false; // 只操作为true的
      }
    })
    // console.log(this.data.list);
    //记录手指触摸开始坐标
    this.setData({
      startX: e.changedTouches[0].clientX, // 开始X坐标
      startY: e.changedTouches[0].clientY, // 开始Y坐标
      list: this.data.list
    })
  },

  // 手指触摸后移动
  touchMove (e) {
    let that = this,
    index = e.currentTarget.dataset.id,    // 当前下标
    startX = that.data.startX,                // 开始X坐标
    startY = that.data.startY,                // 开始Y坐标
    touchMoveX = e.changedTouches[0].clientX, // 滑动变化坐标
    touchMoveY = e.changedTouches[0].clientY, // 滑动变化坐标
    // 获取滑动角度
    angle = that.angle({ X: startX, Y: startY }, { X: touchMoveX, Y: touchMoveY });
　　// 判断滑动角度
    that.data.list.forEach(item => {
      item.isTouchMove = false;
       // 滑动超过30度角 return
      if (Math.abs(angle) > 30) {
          return;
      }
      if (item.goodsId == index) {
        // console.log(touchMoveX,startX);
        // 右滑
        if (touchMoveX > startX) 
          item.isTouchMove = false
        // 左滑
        else 
          item.isTouchMove = true
      }
    });  
     // 更新数据
    that.setData({
      Goods: that.data.list
    })  
  },

  // 计算滑动角度
  angle: function (start, end) {
    let that = this,
      _X = end.X - start.X,
      _Y = end.Y - start.Y;
    // 返回角度 /Math.atan()返回数字的反正切值
    return 360 * Math.atan(_Y / _X) / (2 * Math.PI);
  },

  // 删除
  delGoods: function (e) {
   let index = e.currentTarget.dataset.index; // 当前下标
    console.log(index);
    // 切割当前下标元素，更新数据
    deleteGoods("/goods/"+index,{}).then((res) => {
        console.log(res);
        wx.showToast({
          title: '删除成功',
          duration:4000,
          icon:"success",
        })
        this.GoodsInfo();
    })
    .catch((err) => {
      console.log("物品删除失败", err);
    });
  }
})