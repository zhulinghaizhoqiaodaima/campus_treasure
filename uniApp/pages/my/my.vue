<template>
	<view>
		<!--用户授权 -->
		<view class="header" v-if="isShowUserName">
			<image class="userinfo-avatar" :src="userInfo.avatar"></image>
			<text class="userinfo-nickname">{{userInfo.nickname}}</text>
			<text class="logout" @click="logout">退出登录</text>
			<block>
				<view class='my_item' @click="goMyInfo">
					<text>个人信息</text>
					<view class='right_arrow' />
				</view>
				<view class='my_item' @click="goMyGoods">
					<text>发布列表</text>
					<view class='right_arrow' />
				</view>

			</block>

		</view>
		<!--如果用户没有授权，显示登陆按钮  -->
		<block v-if="!isShowUserName">
			<view class="header">
				<image class="userinfo-avatar" src="../../static/imgs/title.png"></image>
				<text class="userinfo-nickname">用户</text>
			</view>
			<view class="btn-login">
				<button type="primary" @click="myLogin">授权登陆</button>
			</view>
		</block>
	</view>
</template>

<script>
	const app = getApp();
	export default {
		data() {
			return {
				isShowUserName: false,
				userInfo: null,
			}
		},
		onLoad() {
			if (app.globalData.userInfo) {
				this.userInfo = app.globalData.userInfo;
			}
		},
		onShow() {
			if (app.globalData.userInfo != null) {
				if (app.globalData.userInfo.avatar == "") {
					app.globalData.userInfo.avatar = "../../static/imgs/title.png";
				}
				this.isShowUserName = true;
				this.userInfo = app.globalData.userInfo;
			}
		},
		methods: {
			//退出登录
			logout() {
				this.userInfo = null;
				this.isShowUserName = false;
				app.globalData.userInfo = null;
			},
			myLogin() {
				uni.redirectTo({
					url: '../login/login',
				})
			},
			goMyGoods() {
				uni.navigateTo({
					url: '../myGoods/myGoods',
				})
			},
			goMyInfo() {
				uni.navigateTo({
					url: '../myInfo/myInfo',
				})
			},
		}
	}
</script>

<style>
	page {
		background: linear-gradient(91deg, #f1eefc, #9dc6ff 70%, #a5bcff);
	}

	.header {
		width: 100%;
		display: flex;
		flex-direction: column;
		padding-bottom: 15px;
		align-items: center;
		background: linear-gradient(91deg, #f1eefc, #9dc6ff 70%, #a5bcff);

	}

	.btn-login {
		padding: 8%;
		background: linear-gradient(91deg, #f1eefc, #9dc6ff 70%, #a5bcff);
	}

	.logout {
		color: gray;
		padding: 20rpx;
	}

	.userinfo-avatar {
		border-radius: 158rpx;
		width: 158rpx;
		height: 158rpx;
		margin-block-start: 10px;

	}

	.userinfo-nickname {
		margin-top: 20rpx;
		font-size: 42rpx;
	}

	.runner_desc {
		font-size: 10pt;
		color: red
	}

	.dizhizi {
		color: white
	}

	.dizhi {
		margin-top: 200px;
	}

	/*  下面是关键去除边框 */
	.button {
		width: 100%;
		background: white;
		border: none;
		text-align: left;
		padding: 0px;
		margin: 0px;
		line-height: 1.5;
		font-size: 16px
	}

	/*  下面是关键去除边框 */
	.button::after {
		border: none;
		border-radius: 0;
	}
</style>
