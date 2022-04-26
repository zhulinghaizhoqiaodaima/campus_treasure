<template>
	<view>
		<!-- 分类列表 -->
		<view>
			<view class="contain">
				<view class="select_box" v-for="(item,index) in selectList" :key="index">
					<view class="select_tab" :class="[item.active ? 'active':'',item.active?'active':'']"
						:data-id="index" @click="chooseTab">
						<view>{{ item.active || item.name }}</view>
						<image src="../../static/imgs/up.png" class="arrow" v-if="showIndex != index" />
						<image src="../../static/imgs/down.png" class="arrow" v-if="showIndex == index" />
					</view>
					<scroll-view class="option_list" :class="showIndex == index ? 'slidedown' : 'slideup'">
						<view v-for="(val,vIndex) in item.list" :key="vIndex" class="option_item"
							:class="item.active == val.content?'active_option':''" :data-index="index"
							:data-value="val.content" @click="chooseOption">{{ val.content }}</view>
					</scroll-view>
				</view>
			</view>
		</view>

		<!-- 物品列表 -->
		<view class="goodsList">
			<view class="goods_list" v-for="(item,index) in Goods" :key="index" :data-id="item.goodsId"
				@click="goodsDetails">
				<view class="goodsWarp">
					<image class="goodsImg" mode="aspectFill" :src="item.goodsImg" />
					<view class="goodRoot">
						<view class="goodsTitle">{{item.goodsName}}</view>
						<view class="containStepper">
							<view class="goodsPhone">{{"联系方式: "+ item.contactInfo}}</view>
							<view class="goodsTime">{{"发布时间" + item.time}}</view>
						</view>
					</view>
				</view>
			</view>
		</view>
		<!-- 页面无数据时 -->
		<!-- <view class="noData">您搜索的物品不存在或已被删除</view> -->
	</view>
</template>

<script>
	export default {
		data() {
			return {
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
				noData:false,
				Goods:[],
			}
		},
		methods: {
			// 选中select_tab
			chooseTab(e) {
				console.log(this.showIndex)
				let index = e.currentTarget.dataset.id;
				if (index !== this.showIndex) {
					// this.setData({
					// 	showIndex: index
					// })
					this.showIndex = index;
				} else {
					this.showIndex = -1;
				}
			},
			// 选中选项
			chooseOption(e) {
				const val = e.currentTarget.dataset.value,
					idx = e.currentTarget.dataset.index;
				this.GoodsInfo(this.options,val);
				console.log(this.selectList[idx].active)
				this.selectList[idx].active = val;
				this.showIndex = -1;
			},
			async GoodsInfo(data,classification) {
				 console.log(data.searchKey,classification,data.text);
				try {
					const res = await this.$http.get('/goods/page', {
						pageNum: 1,
						pageSize: 20,
						category:  data.text == undefined ? "" : data.text,
						classification: classification == undefined ? "" : classification,
						goodsName: data.searchKey == undefined ? "" : data.searchKey
					})
					this.GoodsList(res);
				} catch (err) {
					console.log("物品数据获取失败", err);
				}
			},
			GoodsList(res) {
				console.log(res);
				if (res.records.length > 0) {
					this.noData = true;
				}
				res.records.forEach(item => {
					if (item.goodsImg == null) {
						item.goodsImg = "../../static/imgs/banner/1.png";
					}
				});
				this.Goods = res.records;
			},
		  goodsDetails(e) {
			console.log(e.currentTarget.dataset.id);
			uni.navigateTo({
			  url: '../goodsDetails/goodsDetails?id=' + e.currentTarget.dataset.id
			})
		  }

		},
		onLoad(opt) {
			this.options = opt;
			console.log(opt);
			this.GoodsInfo(opt);
		}
	}
</script>

<style>
	/**
	下拉选择分类框
	**/
	page {
		background-color: #f6f7f9;
		position: relative;
	}

	.contain {
		display: flex;
		/* position: fixed; */
	}

	.select_box {
		line-height: 80rpx;

	}

	.select_tab {
		width: 250rpx;
		background-color: #fff;
		/* background-color: #969799; */
		display: flex;
		justify-content: center;
		align-items: center;
		position: relative;
		z-index: 20;
		border-bottom-right-radius: 20rpx;
	}

	.option_list {
		width: 250rpx;
		background-color: #fff;
		/* background-color: #1296db; */
		position: absolute;
		z-index: 10;
	}

	.option_item {
		color: #888;
		text-align: center;
	}

	.arrow {
		width: 45rpx;
		height: 45rpx;
	}

	.active {
		color: #1296db;
	}

	.active_option {
		color: #1296db;
		background-color: #e5f2ff;
	}

	.tips {
		line-height: 2;
		background-color: #fff;
		margin-top: 50rpx;
		padding: 40rpx;
	}

	/* 动画效果 */
	@keyframes slideup {
		from {
			max-height: 600rpx;
		}

		to {
			max-height: 0;
		}
	}

	.slideup {
		animation: slideup 0.2s ease-in both;
	}

	@keyframes slidedown {
		from {
			max-height: 0;
		}

		to {
			max-height: 600rpx;
		}
	}

	.slidedown {
		animation: slidedown 0.2s ease-in both;
	}





	/*Goods列表  */
	.goodsList {
		margin-top: 8rpx;
		background-color: #fff;
		padding-top: 5rpx;
		padding-left: 20rpx;
	}

	.goods_list {
		background-color: #f6f7f9;
		margin-bottom: 10rpx;
	}


	.goodsWarp {
		display: flex;
		align-items: center;
		/* background-color: #ffffff; */
		height: 250rpx;
		margin-top: 5rpx;
	}

	.goodsImg {
		width: 220rpx;
		height: 220rpx;
		border-radius: 15rpx;
	}

	.goodRoot {
		margin-left: 15rpx;
		display: inline-block;
	}

	.goodsTitle {
		font-weight: bolder;
		font-size: 40rpx;
		margin-top: -15rpx;
		margin-left: 5rpx;
		margin-bottom: 75rpx;
	}

	.goodsPhone {
		margin-left: 130rpx;

	}

	.goodsTime {
		margin-top: 35rpx;
		font-size: 22rpx;
		color: #969799;
		margin-left: 140rpx;
	}

	.noData {
		width: 100%;
		height: 100%;
		background-color: aliceblue;
		font-size: 40rpx;
		overflow-y: hidden;
		margin: 100rpx;
		color: #999;
	}
</style>
