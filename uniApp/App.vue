<script>
	export default {
		globalData: {
			userInfo: {
			}, // 用户信息
		},
		onLaunch: function() {
			console.log('App Launch')
		},
		onShow: function() {
			console.log('App Show')
		},
		onHide: function() {
			console.log('App Hide')
		}
	}
</script>

<style>
	body{
	  font-family: -apple-system, BlinkMacSystemFont, 'Helvetica Neue', Helvetica,
	  Segoe UI, Arial, Roboto, 'PingFang SC', 'Hiragino Sans GB', 'Microsoft Yahei',
	  sans-serif;
	}
	.container {
	  display: flex;
	  flex-direction: column;
	  min-height: 100%;
	}
	/*个人中心的条目布局,全局统一布局  */
	.my_item {
	  width: 100%;
	  display: flex;
	  flex-direction: row;
	  align-items: center;
	  padding: 17px;
	  background: white;
	  border-bottom: 1px solid gainsboro;
	}
	.line_5px {
	  height: 15px;
	}
	.line_8pt {
	  height: 8pt;
	}
	.line_1px {
	  height: 1px;
	  background: gainsboro
	}
	.right_arrow {
	  border: solid black;
	  border-width: 0 3px 3px 0;
	  padding: 3px;
	  position: absolute;
	  right: 15px;
	  /* margin-left: 66%; */
	  transform: rotate(-45deg);
	  -webkit-transform: rotate(-45deg);
	}
	button::after {
	  border: none;
	}
	button {
	  background-color: #fff;
	}
	button {
	  border-radius:0;
	  border-radius: 0;
	  font-weight: bolder;
	  padding: 0;
	}
</style>
