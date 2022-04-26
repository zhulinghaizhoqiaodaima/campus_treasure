<template>
	<view>
		<!-- 搜索区域 -->
		<view>
			<view class="weui-search-bar">
				<view class="weui-search-bar__form">
					<!-- 搜索框 -->
					<view class="weui-search-bar__box">
						 <icon class="weui-icon-search_in-box" type="search" size="14"/>
						<input class="weui-search-bar__input" @input="goSearchKey" placeholder="输入关键字" />
					</view>
				</view>
				<!-- 搜索按钮,调用搜索查询方法 -->
				<view class="weui-search-bar__cancel-btn" @click='goSearch'>搜索</view>
			</view>
		</view>

		<!-- 轮播图区域 -->
		<view>
			<swiper class="bd" indicator-dots="true" indicator-active-color="#ff8f00" autoplay="true" circular="true">
				<block class='lbtp' v-for="(item,i) in banner" :key="i">
					<swiper-item>
						<image :src="item.picUrl" mode="widthFix" style="width:100%;height:100%;" />
					</swiper-item>
				</block>
			</swiper>
		</view>

		<!-- 九宫格区域 -->
		<view class="section">
			<view class="tui-table-view">
				<view class="tui-col-3" v-for="(item,i) in funArea" :key="i" :data-item="item" @click="goodsPage">
					<image class="category_item_image" :src="item.picUrl" />
					<view class="text">{{item.text}}</view>
				</view>
			</view>
		</view>

	</view>
</template>

<script>
	export default {
		data() {
			return {
				banner: [{
						picUrl: '../../static/imgs/banner/1.png'
					},
					{
						picUrl: '../../static/imgs/banner/2.png'
					}, {
						picUrl: '../../static/imgs/banner/3.png'
					},
				],
				funArea: [{
					picUrl: '../../static/imgs/fun/book.png',
					text: "书籍"
				}, {
					picUrl: '../../static/imgs/fun/card.png',
					text: "磁卡"
				}, {
					picUrl: '../../static/imgs/fun/key.png',
					text: "钥匙"
				}, {
					picUrl: '../../static/imgs/fun/phone.png',
					text: "手机"
				}, {
					picUrl: '../../static/imgs/fun/wallet.png',
					text: "钱包"
				}, {
					picUrl: '../../static/imgs/fun/other.png',
					text: "其他"
				}, ],
				searchKey: "",
			}
		},
		methods: {
			goSearchKey(e){
				this.searchKey = e.detail.value;
			},
			//搜索点击事件
			goSearch(e) {
			console.log(e)
			  uni.navigateTo({
				url: '../goodsPage/goodsPage' + '?searchKey=' + this.searchKey,
			  })
			},
			goodsPage(e) {
				let dataset = e.currentTarget.dataset;
				console.log(dataset.item.text);
				uni.navigateTo({
					url: "../goodsPage/goodsPage?text=" + dataset.item.text
				})
			}
		},
		onShow() {}
	}
</script>

<style>
	/* 搜索 */
	.weui-search-bar {
		position: relative;
		padding: 8px 10px;
		display: -webkit-box;
		display: -webkit-flex;
		display: flex;
		box-sizing: border-box;
		background-color: #EFEFF4;
		border-top: 1rpx solid #D7D6DC;
		border-bottom: 1rpx solid #D7D6DC;
	}

	.weui-icon-search_in-box {
		position: absolute;
		left: 10px;
		top: 7px;
	}

	.weui-search-bar__form {
		position: relative;
		-webkit-box-flex: 1;
		-webkit-flex: auto;
		flex: auto;
		border-radius: 5px;
		background: #FFFFFF;
		border: 1rpx solid #E6E6EA;
	}

	.weui-search-bar__box {
		position: relative;
		padding-left: 30px;
		padding-right: 30px;
		width: 100%;
		box-sizing: border-box;
		z-index: 1;
	}

	.weui-search-bar__input {
		height: 28px;
		line-height: 28px;
		font-size: 14px;
	}

	.weui-search-bar__cancel-btn {
		margin-left: 10px;
		line-height: 28px;
		color: #09BB07;
		white-space: nowrap;
	}

	/* 轮播图区域 */
	.bd .wx-swiper-dots.wx-swiper-dots-horizontal {
		margin-bottom: 2rpx;
	}

	.bd .wx-swiper-dot {
		width: 40rpx;
		/*点的长*/
		display: inline-flex;
		height: 10rpx;
		/*点的高*/
		margin-left: 5rpx;
		/*两个点的距离*/
		justify-content: space-between;
	}

	.bd .wx-swiper-dot::before {
		content: '';
		flex-grow: 1;
		background: #d7d7d7;
		/*点的未选中颜色*/
		border-radius: 8rpx
	}

	.bd .wx-swiper-dot-active::before {
		background: #ff8f00;
		/*点的选中颜色*/
	}

	/* 功能区 */
	.section {
		margin-top: 60rpx;
		background-color: #f6f7f9;
		border-radius: 30rpx;
	}

	.tui-table-view {
		display: -webkit-flex;
		display: flex;
		align-items: center;
		justify-content: space-between;
		flex-wrap: wrap;
		width: 100%;
	}

	.tui-col-3 {
		flex: 0 0 auto;
		width: 33.33333333%;
		text-align: center;
		color: #797979;
		padding: 40rpx 0;
		font-size: 30rpx;
	}

	.category_item_image {
		height: 100rpx;
		width: 100rpx;
	}

	.text {
		font-size: 11px;
		font-weight: bolder;
	}
</style>
