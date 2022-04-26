<template>
	<view id="total">
		<image src="../../static/imgs/title.png"></image>
		<form @submit="create_login">
			<view class="Sno public_css">
				<text>学号</text>
				<input type="text" placeholder="输入学号" @input="getStu"></input>
			</view>
			<view class="pwd public_css">
				<text>密码</text><input type="password" placeholder="输入密码" @input="getPwd"></input>
			</view>
			<button bindtap="goto_index" id="btn1" form-type="submit"><text>登陆</text></button>

		</form>

		<view class="btn_wrap">
			<button @click="register" class="user_register"><text>注册</text></button>
		</view>
	</view>
</template>

<script>
	const app = getApp();
	export default {
		data() {
			return {
				username: null,
				password: null,
			}
		},
		methods: {
			getPwd(e) {
				this.password = e.target.value;
			},
			getStu(e) {
				this.username = e.target.value;
			},
			async create_login() {
				// this.$message.toast('回答已删除')
				try{
					const res = await this.$http.post('/user/login',{
						stuNum: this.username,
						password: this.password,
					});
					if (res.code === '200') {
						app.globalData.userInfo = res.data;
						console.log(res.data);
						uni.showToast({
							title: "登录成功",
							duration: 2000
						})
						uni.switchTab({
							url: '../home/home',
						})
					} else {
						uni.showToast({
							title: res.msg,
							icon: 'none',
							duration: 3000
						})
					}
				}catch(err){
					console.log("登录失败", err);
				}
			},
			register(res) {
				uni.navigateTo({
					url: '../register/register',
				})
			}
		}
	}
</script>

<style>
	#total {
		width: 100%;
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
		top: 350rpx;
		background-color: rgb(51, 204, 170);
		width: 600rpx;
		border-radius: 50rpx;
	}

	#btn1 text {
		color: white;
		font-size: 39rpx;
	}

	.btn_wrap {
		position: relative;
		top: 370rpx;
		text-align: center;
	}

	.btn_wrap text {
		color: black;
		font-size: 39rpx;
	}

	.user_register,
	.update_pwd {
		background-color: #fff;
		display: inline-block;
		/* left: 194rpx; */

	}
</style>
