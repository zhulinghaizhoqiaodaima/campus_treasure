<template>
	<view>
		<scroll-view scroll-y enable-back-to-top :style='{height:scrollHeight}'>
			<view class="goodsList">
				<block class="goods_list" v-for="(item,index) in Goods" :key="index">
					<view class="goodsWarp list" :class="item.isTouchMove ? 'touch-move-active' : ''"
						:data-id="item.goodsId" @touchstart="touchStart" @touchmove="touchMove">
						<view class="txt">
							<image class="goodsImg" mode="aspectFill" :src="item.goodsImg" />
							<view class="goodRoot">
								<view class="goodsTitle">{{item.goodsName}}</view>
								<view class="containStepper">
									<view class="goodsPhone">{{"联系方式: "+ item.contactInfo}}</view>
									<view class="goodsTime">{{"发布时间" + item.time}}</view>
								</view>
							</view>
						</view>
						<view class="del" @click="delGoods" :data-index="item.goodsId"> 删除 </view>
					</view>
				</block>
			</view>
		</scroll-view>
	</view>
</template>

<script>
	const app = getApp();
	export default {
		data() {
			return {
				scrollHeight: 0, // scroll-view高度
				startX: 0, // 开始X坐标
				startY: 0, // 开始Y坐标
				Goods: [],
			}
		},
		onLoad() {

			this.scrollHeight = `${uni.getSystemInfoSync().screenHeight}px`;
			this.GoodsInfo();
		},
		methods: {
			async GoodsInfo() {
				try {
					const res = await this.$http.get('/goods/my/goods', {
						stuNum: app.globalData.userInfo.stuNum
					});
					console.log("个人物品", res);
					res.data.forEach(item=>{
						item.isTouchMove = false;
					})
					this.Goods = res.data;
				} catch (e) {
					//TODO handle the exception
					console.log("个人物品获取失败", e)
				}
			},
			// 手指触摸动作开始
			touchStart(e) {
				//开始触摸时 重置所有删除
				this.Goods.forEach(item => {
					if (item.isTouchMove) {
						item.isTouchMove = false; // 只操作为true的
					}
				})
				//记录手指触摸开始坐标
				this.startX = e.changedTouches[0].clientX;
				this.startY = e.changedTouches[0].clientY;
			},

			// 手指触摸后移动
			touchMove(e) {
				let index = e.currentTarget.dataset.id, // 当前下标
					startX = this.startX, // 开始X坐标
					startY = this.startY, // 开始Y坐标
					touchMoveX = e.changedTouches[0].clientX, // 滑动变化坐标
					touchMoveY = e.changedTouches[0].clientY, // 滑动变化坐标
					// 获取滑动角度
					angle = this.angle({
						X: startX,
						Y: startY
					}, {
						X: touchMoveX,
						Y: touchMoveY
					});
				// 判断滑动角度
				this.Goods.forEach(item => {
					
					// item.isTouchMove = false;
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
				
			},

			// 计算滑动角度
			angle(start, end) {
				let _X = end.X - start.X,
					_Y = end.Y - start.Y;
				// 返回角度 /Math.atan()返回数字的反正切值
				return 360 * Math.atan(_Y / _X) / (2 * Math.PI);
			},

			// 删除
			async delGoods(e) {
				let index = e.currentTarget.dataset.index; // 当前下标
				console.log(index);
				// 切割当前下标元素，更新数据
				try {
					const res = await this.$http.post('/goods/' + index);
					console.log(res)
					wx.showToast({
						title: '删除成功',
						duration: 4000,
						icon: "success",
					})
					this.GoodsInfo();
				} catch (e) {
					//TODO handle the exception
				}
			}
		}
	}
</script>

<style>
	page {
		position: relative;
	}

	/* 列表内容 */
	.list .txt {
		flex-grow: 1;
		width: 100%;
		margin-left: -150rpx;
	}

	/* 删除按钮 */
	.list .del {
		flex-grow: 0;
		width: 150rpx;
		height: 220rpx;
		color: #fff;
		background-color: #fe3e2f;
		line-height: 220rpx;
		text-align: center;
	}

	.list .txt,
	.list .del {
		transform: translateX(150rpx);
		transition: all 0.4s;
	}

	.touch-move-active .txt,
	.touch-move-active .del {
		-webkit-transform: translateX(0);
		transform: translateX(0);
	}

	/*Goods列表  */
	.goodsList {
		margin-top: 8rpx;
		background-color: #f6f7f9;
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
		background-color: #fff;
		height: 250rpx;
		margin-top: 10rpx;
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
</style>
