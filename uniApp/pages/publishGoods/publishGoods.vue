<template>
	<view>
		<form @submit="ConfirmInfo">
			<view class="title">
				<input class="titleInput" name="goodsName" placeholder="请输入标题" v-model="goodsName"></input>
			</view>
			<view class='title'>
				<picker @change="bindGoodsChange" :range="goodsStateArr" :value="goodsStateIndex">
					<input type='text' placeholder="物品状态" name="classification"
						:value="goodsStateArr[goodsStateIndex]"></input>
				</picker>
			</view>
			<view class='title'>
				<picker @change="bindGoodsType" :value="GoodsTypeIndex" :range="category">
					<input type='text' placeholder="物品分类" name="category" :value="category[GoodsTypeIndex]"></input>
				</picker>
			</view>
			<view class="title">
				<input class="getPlace" placeholder="获取地点" @click="onChangeAddress" :value="getplace" name="place">
				</input>
			</view>
			<view class="title">
				<input class="titleInput" placeholder="联系方式" v-model="contactInfo" name="contactInfo"></input>
			</view>
			<view class="title">
				<textarea class="textInput" maxlength="60" placeholder="信息备注->限60字" v-model="remarks" name="remarks"></textarea>
			</view>
			<!--上传图片-->
			<view class="weui-uploader">
				<view class="img-v weui-uploader__bd">
					<view class='pic' v-if="goodsImg">
						<image class='weui-uploader__img ' :src="goodsImg">
						</image>
					</view>
				</view>
				<button class="upload-img-btn" @click="chooseImg" type='primary'>拍照 / 上传</button>
			</view>
			<button class='sureRelease' form-type="submit">确认发布</button>
		</form>
	</view>
</template>

<script>
	let app = getApp();
	export default {
		data() {
			return {
				imgs: [],
				goodsStateArr: ['拾取', '丢失'],
				goodsStateIndex: null,
				category: ['书籍', '磁卡', '钥匙', '手机', '钱包', '其他'],
				GoodsTypeIndex: null,
				goodsInfo: {},
				getplace: "",
				goodsImg: "",
				goodsName:"",
				contactInfo:"",
				remarks:"",
				
			}
		},
		methods: {
			bindGoodsChange(e) {
				let goodsStateIndex = parseInt(e.detail.value);
				this.goodsInfo.classification = this.goodsStateArr[goodsStateIndex];
				console.log('picker发送选择改变，携带值为', goodsStateIndex);
				this.goodsStateIndex = goodsStateIndex;
			},
			//物品分类
			bindGoodsType(e) {
				let GoodsTypeIndex = parseInt(e.detail.value);
				console.log(this.category[GoodsTypeIndex]);
				console.log('picker发送选择改变，携带值为', GoodsTypeIndex);
				this.GoodsTypeIndex = GoodsTypeIndex;
				this.goodsInfo.category = this.category[GoodsTypeIndex];
			},
			//移动选点
			onChangeAddress(e) {
				uni.showLoading({
					title: '加载中',
					mask: true
				})
				uni.chooseLocation({
					success: res => {
						uni.hideLoading();
						this.getplace = res.name;
						this.goodsInfo.place = res.name;
						console.log(this.goodsInfo.place)
					},
					fail: err => {
						console.log(err)
						uni.hideLoading();
					}
				});
			},
			// 上传图片
			chooseImg(e) {
				wx.chooseImage({
					sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
					sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
					success: res => {
						// 返回选定照片的本地文件路径列表，tempFilePath可以作为img标签的src属性显示图片
						this.goodsInfo.goodsImg = res.tempFilePaths[0];
						this.goodsImg = res.tempFilePaths[0];
					}
				});

			},
			//发布数据
			ConfirmInfo(e) {
				if (this.goodsInfo.goodsImg) {
					uni.uploadFile({
						url: 'http://localhost:8088/file/upload',
						filePath: this.goodsInfo.goodsImg,
						name: 'file',
						formData: {
							'user': 'test'
						},
						success: res => {
							this.goodsInfo.goodsImg = res.data;
							this.pullGoodsData(e);
						}
					})
				}
				this.pullGoodsData(e);
			},
			async pullGoodsData(e) {
				// console.log('form发生了submit事件，携带数据为：',e.detail.value);
				let obj = Object.assign({}, this.goodsInfo, e.detail.value)
				this.goodsInfo = JSON.parse(JSON.stringify(obj));
				this.goodsInfo.stuNum = app.globalData.userInfo.stuNum;
				console.log(Object.values(this.goodsInfo).length, Object.keys(this.goodsInfo).length);
				const {
					goodsName,
					classification,
					category,
					place,
					contactInfo
				} = this.goodsInfo;
				const TIPMSG = "不能为空";
				if (goodsName == "") {
					this.$message.toast(`物品名称${TIPMSG}`);
					return;
				}
				if (classification == "") {
					this.$message.toast(`物品状态${TIPMSG}`);
					return;
				}
				if (category == "") {
					this.$message.toast(`物品分类${TIPMSG}`);
					return;
				}
				if (place == "") {
					this.$message.toast(`地点${TIPMSG}`);
					return;
				}
				if (contactInfo == "") {
					this.$message.toast(`联系方式${TIPMSG}`);
					return;
				}
				try {
					const res = await this.$http.post('/goods/save', this.goodsInfo);
					this.ClearGoodsData();
					uni.showToast({
						title: "发布成功",
						duration: 3000,
						success: function() {
							setTimeout(function() {
								wx.switchTab({
									url: '../home/home',
								})
							}, 2000);
						}
					});
					this.$refs.resrtBtn.$dispatch('Form', 'uni-form-reset', {
						type: 'reset'
					})
				} catch (e) {
					//TODO handle the exception
					console.log('发布失败', e);
				}
			},
			//清除数据
			ClearGoodsData() {
				this.goodsName = "";
				this.getplace = "";
				this.goodsImg = "";
				this.contactInfo = "";
				this.remarks = "";
				this.GoodsTypeIndex = null;
				this.goodsStateIndex = null;
				this.goodsImg = "";
			}
		},
		
	}
</script>

<style>
	page {
		background-color: #f1f1f1;
	}

	.title {
		width: 100%;
		margin: 20rpx auto;
		background-color: #fff;
	}

	input {
		margin: 20rpx;
		height: 90rpx;
		color: #333;
		box-sizing: border-box;
	}

	.textInput {
		margin: 20rpx;
		height: 200rpx;
		color: #333;
		box-sizing: border-box;
	}

	/* 获取当前地址 */
	.getPlace {
		color: #007ACC;
	}

	.sureRelease {
		background-color: darkorange;
	}

	/* 上传照片 */
	/* pages/upload/upload.wxss */
	.img {
		display: inline-block;
	}

	.pic {
		float: left;
		position: relative;
		margin-right: 9px;
		margin-bottom: 9px;
	}

	.delete-btn {
		position: absolute;
		top: 0;
		right: 0;
	}

	.weui-uploader {
		padding: 10rpx;
	}


	.lineHeight {
		width: 100%;
		line-height: 80rpx;
		border-bottom: 1px solid #ccc;
		font-size: 30rpx;
	}

	.container {
		padding: 0;
		align-items: left;
		padding-left: 15rpx;
	}

	.numberInfo {
		font-size: 24rpx;
		text-indent: 15rpx;
		border-bottom: 1px solid #ccc;
	}

	button {
		width: 50vw;
		margin-top: 30rpx;
		border-radius: 10rpx;
	}

	.select {
		margin-left: 7%;
		color: #666;
	}
</style>
