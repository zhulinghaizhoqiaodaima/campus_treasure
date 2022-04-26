import {
  getGoodsInfo
} from "../../api/getGoodsInfo";
Page({
  data: {
    options:null,
    selectList: [
			{
				name: '分类',
				list: [
					{ id: 1, content: '拾取' },
					{ id: 2, content: '丢失' },
				]
			},
	
		],
		showIndex: -1,
  },
  onLoad: function (opt) {
    this.data.options = opt;
    console.log(opt);
    this.GoodsInfo(opt);
  },
  GoodsInfo(data,classification) {
   console.log(data.searchKey,classification,data.text);
    getGoodsInfo({
      pageNum:1,
      pageSize:20,
      category:data.text,
      classification:classification,
      goodsName:data.searchKey
    }).then((res) => {
        this.GoodsList(res);
    })
    .catch((err) => {
      console.log("物品数据获取失败", err);
    });
  },
  GoodsList(res) {
    console.log(res);
    if(res.records.length == 0) {
      this.setData({
        NoData:false,
      })
    }else{
      this.setData({
        NoData:true,
      })
    }
    res.records.forEach(item => {
        if(item.goodsImg == null) {
          item.goodsImg = "../../imgs/banner/1.png";
        }
    });
    this.setData({
      Goods:res.records
    })
  },
  	// 选中select_tab
	chooseTab(e){
    let index = e.currentTarget.dataset.id;
		if(index !== this.data.showIndex){
			this.setData({
				showIndex: index
			})
		}else{
			// 再次点击应该收起
			this.setData({
				showIndex: -1
			})
		}
	},
	// 选中选项
	chooseOption(e){
		let val = e.currentTarget.dataset.value,
      idx = e.currentTarget.dataset.index;
      this.GoodsInfo(this.options,val);
		this.setData({
			[`selectList[${idx}].active`]: val,
			showIndex: -1
    });
  },
  goodsDetails(e) {
    console.log(e.currentTarget.dataset.id);
    wx.navigateTo({
      url: '../goodsDetails/goodsDetails?id=' + e.currentTarget.dataset.id
    })
  }
})