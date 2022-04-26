// pages/home/home.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    banner: [{
        picUrl: '../../imgs/banner/1.png'
      },
      {
        picUrl: '../../imgs/banner/2.png'
      }, {
        picUrl: '../../imgs/banner/3.png'
      },
    ],
    funArea: [{
      picUrl: '../../imgs/fun/book.png',
      text:"书籍"
    },{
      picUrl: '../../imgs/fun/card.png',
      text:"磁卡"
    },{
      picUrl: '../../imgs/fun/key.png',
      text:"钥匙"
    },{
      picUrl: '../../imgs/fun/phone.png',
      text:"手机"
    },{
      picUrl: '../../imgs/fun/wallet.png',
      text:"钱包"
    },{
      picUrl: '../../imgs/fun/other.png',
      text:"其他"
    }
  ],
  searchKey:"",
  },
  goodsPage(e) {
    let dataset = e.currentTarget.dataset;
    console.log(dataset.item.text);
    wx.navigateTo({
      url: "../goodsPage/goodsPage?text=" +dataset.item.text
    })
  },
  getSearchKey(e) {
    console.log( e.detail.value);
    this.data.searchKey = e.detail.value
  },
    //搜索点击事件
    goSearch() {
      this.setData({
        SearchWord:"",
      })
      wx.navigateTo({
        url: '../goodsPage/goodsPage' + '?searchKey=' + this.data.searchKey,
      })
    },
})