<template>
	<view class="page">
		<image class="good_img" mode="aspectFill" :src="goodsInfo.goodsImg"></image>
		<view class="top_info">
			<view class="good_title">{{goodsInfo.category}}</view>

			<view class="goodPhone"><text class="phoneText">联系方式</text>{{" "+goodsInfo.contactInfo}}</view>
			<view class="goodsState">{{"地点: "+goodsInfo.place}}</view>
			<view class="goodsState">{{"发布时间:"+ goodsInfo.time}}</view>
			<view></view>
		</view>
		<view class="good_detail">
			<view class="good_detail_title">备注信息</view>
			<view class="good_detail_context">{{goodsInfo.remarks}}</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				goodsInfo: null,
			}
		},
		onLoad(options) {
			console.log(options)
			this.goodsDetail(options.id)
		},
		methods: {
			async goodsDetail(id) {
				try {
					const res = await this.$http.post("/goods/one/" + id);
					this.goodsRender(res)
				} catch (e) {
					console.log("物品详细数据获取失败", e);
				}
			},
			goodsRender(data) {
				if (data.goodsImg == null) {
					data.goodsImg = "../../static/imgs/banner/1.png";
				}
				this.goodsInfo = data;
			},
		}
		
	}
</script>

<style>
	.page {
		background-color: #f7f8fa;
	}

	.good_img {
		display: block;
		width: 100%;
		height: 500rpx;
		/* object-fit:cover */
	}

	.top_info {
		background-color: #ffffff;
		width: 100%;
		padding-top: 30rpx;
	}

	.good_title {
		font-size: 42rpx;
		margin-left: 30rpx;
		font-weight: bolder;
		letter-spacing: 4rpx;
	}

	.goodsState {
		color: #969799;
		margin-left: 30rpx;
		margin-top: 10rpx;
		font-size: 20rpx;
		letter-spacing: 4rpx;
	}

	.phoneText {
		font-size: 30rpx;
		margin-left: 30rpx;
	}

	.goodPhone {

		margin-top: 30rpx;
		font-size: 50rpx;
		color: #f54756;
		font-weight: bolder;
	}

	.good_detail {
		margin: 20rpx auto;
		width: 100%;
		background-color: #ffffff;
		padding-bottom: 30rpx;
	}

	.good_detail_title {
		margin-left: 20rpx;
		font-size: 37rpx;
		font-weight: 550;
		letter-spacing: 7rpx;
		height: 90rpx;
		line-height: 90rpx;
		border-bottom: 5rpx #f7f8fa solid;
	}

	.good_detail_context {
		font-size: 27rpx;
		letter-spacing: 4rpx;
		padding: 30rpx 30rpx;
		max-height: 200rpx;
		overflow: hidden;
	}

	.good_evaluate {
		width: 100%;
		min-height: 30rpx;
		margin-top: 20rpx;
		background-color: #ffffff;
		padding-bottom: 50rpx;
		padding-left: 20rpx;
	}

	.good_evaluate_title {
		font-size: 37rpx;
		font-weight: 550;
		letter-spacing: 7rpx;
		height: 90rpx;
		line-height: 90rpx;
	}

	.good_evaluate_title>text {
		font-size: 25rpx;
		margin-left: 60vw;
		font-weight: 400;
	}
</style>
