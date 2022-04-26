<template>
	<view>
		<view class="headPortrait">
			<view class="textContent" @click="chooseImg">编辑</view>
			<image class="userAvatar" :src="userInfo.avatar"></image>
		</view>

		<view class="contentWarp">
			<view class="myInfoWrap">
				<view class="text"> {{ "昵称: "}} </view>
				<input class="titleInput" :value="userInfo.nickname" placeholder="请输入昵称" @input="getNickname"></input>
			</view>
			<view class="myInfoWrap">
				<view class="text"> {{ "年级: "}} </view>
				<input class="titleInput" :value="userInfo.grade" placeholder="年级" @input="getGrade">{{}}</input>
			</view>
			<view class="myInfoWrap">
				<view class="text"> {{ "联系方式: "}} </view>
				<input class="titleInput" :value="userInfo.phone" placeholder="联系方式" @input="getContact">{{}}</input>
			</view>


			<button form-type='submit' class='myInfoChange' @click="upUserInfo">修改</button>
		</view>

	</view>
</template>

<script>
	const app = getApp();
	export default {
		data() {
			return {
				userInfo: {},
				grade: null,
				nickname: null,
				phone: null,
				avatar: null,
			}
		},
		onLoad() {
			if (app.globalData.userInfo) {
				this.userInfo = app.globalData.userInfo;
				if (app.globalData.userInfo.avatar == "") {
					this.userInfo.avatar = "../../static/imgs/title.png";
				}
			}
		},
		methods: {
			// 获取昵称
			getNickname(e) {
				console.log(e.detail.value);
				if (e.detail.value != null) {
					this.userInfo.nickname = e.detail.value;
				}
			},
			// 获取年级
			getGrade(e) {
				if (e.detail.value != null) {
					this.userInfo.grade = e.detail.value;
				}
			},
			// 获取联系方式
			getContact(e) {
				if (e.detail.value != null) {
					this.userInfo.phone = e.detail.value;
				}
			},
			    chooseImg (e) {
			      uni.chooseImage({
			        // count: 1, // 默认9
			        sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
			        sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
			        success: res=>{
			          // 返回选定照片的本地文件路径列表，tempFilePath可以作为img标签的src属性显示图片
						this.userInfo.avatar = res.tempFilePaths[0];
			        }
			      });
			    
			    },
				upUserInfo() {
					uni.uploadFile({
					  url: 'http://localhost:8088/file/upload', //仅为示例，非真实的接口地址
					  filePath: this.userInfo.avatar,
					  name: 'file',
					  formData:{
					    'user': 'test'
					  },
					  success: res=>{
					    this.userInfo.avatar = res.data;
						this.InfoChange();
					  }
					})
				},
			    async InfoChange () {
					try{
						const res = await this.$http.post('/user/save',this.userInfo);
						app.globalData.userInfo = res.data;
						uni.showToast({
						  title: "修改成功",
						  duration: 3000
						})
					}catch(e){
						//TODO handle the exception
						console.log("修改失败",e)
					}
			    },
		}
	}
</script>

<style>
	page {
		background-color: #FAFAFA;
	}

	.headPortrait {
		position: relative;
		width: 100%;
		height: 300rpx;
		display: flex;
		flex-direction: column;
		align-items: center;
		background: linear-gradient(180deg, #f1eefc, #9dc6ff 70%, #a5bcff);
		border-bottom-left-radius: 25rpx;
		border-bottom-right-radius: 25rpx;
	}

	.textContent {
		display: flex;
		justify-content: center;
		align-items: Center;
		color: #333;
		margin-left: 200rpx;
		margin-top: 230rpx;
	}

	.userAvatar {
		border-radius: 160rpx;
		width: 160rpx;
		height: 160rpx;
		position: fixed;
		top: 220rpx;
	}

	.contentWarp {
		width: 100%;
		height: 606rpx;
		background: linear-gradient(180deg, #f1eefc, #84ADEA 70%, #a5bcff);
		padding-top: 300rpx;

	}

	.myInfoWrap {
		background-color: #f1eefc;
		margin: 20rpx auto;
		position: relative;
		border-radius: 13rpx;
	}

	.myInfoWrap>.text {
		position: absolute;
		margin: 20rpx auto;
		font-size: 40rpx;
	}

	input {
		margin-left: 170rpx;
		height: 100rpx;
		color: #333;
		box-sizing: border-box;

		border-radius: 20rpx;
		font-size: 40rpx;
	}

	.myInfoChange {
		border-radius: 25rpx;
		background-image: linear-gradient(tobottom, 0%#f0f0f0, 100%#e0e0e0);
	}
</style>
