import {
  getGoodsDatail
} from "../../api/getGoodsDatail";
Page({
  data: {

  },

  onLoad: function (options) {
    console.log(options);
    this.goodsDetail(options.id)
  },
  goodsDetail(id) {
    getGoodsDatail("/goods/one/"+id,{
      
    }).then((res) => {
        console.log(res);
        this.goodsRender(res)
    })
    .catch((err) => {
      console.log("物品数据获取失败", err);
    });
  },
  goodsRender(data) {
    if(data.goodsImg == null) {
      data.goodsImg ="../../imgs/banner/1.png";
    }
    this.setData({
      goodsDetail: data
    })
  },
})