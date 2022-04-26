<template>
	<view id="total">
		<image src="../../static/imgs/title.png"></image>
		<form @submit="register">
			<view class="Sno public_css">
				<text>昵称</text>
				<input type="text" name="nickname" placeholder="输入昵称" @input="getNickname"></input>
			</view>
			<view class="Sno public_css">
				<text>学号</text>
				<input type="text" name="stuNum" placeholder="输入学号" @input="getStuNum"></input>
			</view>
			<view class="pwd public_css">
				<text>密码</text><input type="password" name="pwd" placeholder="输入密码" @input="getPwd"></input>
			</view>
			<view class="grade public_css">
				<text>年级</text>
				<input type="text" placeholder="输入年级" name="grade" @input="getGrade"></input>
			</view>
			<view class="contact_info public_css">
				<text>联系方式</text>
				<input name="phone" placeholder="输入手机号" @input="getPhone"></input>
			</view>

			<button id="btn1" form-type="submit"><text>注册</text></button>
		</form>
	</view>
</template>

<script>
	let app = getApp();
	export default {
		data() {
			return {
				user: {},
			}
		},
		methods: {
			// 以下函数获取全部用户数据
			getNickname(e) {
				this.user.nickname = e.detail.value;
			},
			getStuNum(e) {
				this.user.stuNum = e.detail.value;
			},
			getPwd(e) {
				this.user.pwd = e.detail.value;
			},
			getGrade(e) {
				this.user.grade = e.detail.value;
			},
			getPhone(e) {
				this.user.phone = e.detail.value;
			},
			// 注册用户
			async register() {
				if (Object.values(this.user).length != Object.keys(this.user).length) {
					uni.showToast({
						title: "注册选项不能为空",
						duration: 3000,
						// 弹出框的图标，不想设置图标时请给none
						icon: 'none'
					})
					return;
				}
				try {
					const res = await this.$http.post("/user/register", this.user);
					if (res.data == false) {
						uni.showToast({
							title: "学号已存在",
							icon: 'none',
							duration: 2000
						})
						return;
					}
					if (res.code == "200") {
						uni.showToast({
							title: "注册成功",
							duration: 2000,
							success:res=>{
								this.globalData.userInfo =
								uni.redirectTo({
									url: '../login/login',
								})
							}
						})
					}
				} catch (err) {
					 console.log("注册失败", err);
				}
			}
		}
	}
</script>

<style>
	#total {
		width: 100%;
		height: 100vh;
		background-color: rgb(245, 245, 245);
	}

	image {
		width: 150rpx;
		height: 150rpx;
		position: relative;
		left: 300rpx;
		top: 100rpx;
		border-radius: 50%;
	}

	.public_css {
		width: 100%;
		height: 125rpx;
		background-color: white;
		position: relative;
		top: 200rpx;
		margin-bottom: 10rpx;
	}

	.public_css>text {
		position: relative;
		left: 40rpx;
		top: 40rpx;
		color: rgb(143, 143, 143);
	}

	.public_css>input {
		width: 400rpx;
		height: 80rpx;
		margin-left: 200rpx;
		position: relative;
		bottom: 25rpx;
	}

	#btn1 {
		position: relative;
		top: 250rpx;
		background-color: rgb(51, 204, 170);
		width: 600rpx;
		border-radius: 50rpx;
	}

	#btn1 text {
		color: white;
		font-size: 39rpx;
	}
</style>
