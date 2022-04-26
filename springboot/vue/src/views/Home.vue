<template>
  <div>
    <el-row :gutter="20" style="margin-bottom:70px;">
        <el-col :span="6">
          <el-card style="color:#409EFC">
            <div><i class=""/>物品发布量</div>
            <div style="padding:10px 0; text-align: center; font-weight: bold">{{ this.goodsTotal }}</div>
          </el-card>
        </el-col>
        <el-col :span="6">
          <el-card style="color:#67C23A">
              <div>拾取量</div>
              <div style="padding:10px 0; text-align: center; font-weight: bold">{{ this.goodsFind }}</div>
          </el-card>
        </el-col>
        <el-col :span="6">
          <el-card style="color:#67C23A">
              <div>丢失量</div>
              <div style="padding:10px 0; text-align: center; font-weight: bold">{{ this.goodsLost }}</div>
          </el-card>
        </el-col>  
    </el-row>
    
    <el-row>
      <el-col :span="12">
        <div id="main"></div>
      </el-col>
      <el-col :span="12">
        <div id="pie" style="width: 500px; height: 400px"></div>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import * as echarts from "echarts";
export default {
  name: "Home",
  data() {
    return {
      goodsTotal:null,
      goodsLost:0,
      goodsFind:0,
    };
  },
  methods: {
    getGoodsNum() {
      this.request.get("/goods").then(res=>{
          console.log(res);
          this.goodsTotal = res.length;
          res.forEach(item => {
            if(item.classification == "拾取") {
              this.goodsFind ++;
            }else{
               this.goodsLost ++;
            }
          });
      })

    }

  },
  //页面元素渲染之后在触发
  mounted() {
    // 折线图
    option = {
      title: {
        text: "用户注册",
        subtext: "趋势图",
        left: "center",
      },
      xAxis: {
        type: "category",
        data: ["第一季度", "第二季度", "第三季度", "第四季度"],
      },
      yAxis: {
        type: "value",
      },
      series: [
        {
          data: null,
          type: "line",
        },
        {
          data: null,
          type: "bar",
        },
      ],
    };
    let chartDom = document.getElementById("main");
    let myChart = echarts.init(chartDom);
    let option;
    this.request.get("echarts/userMembers").then((res) => {
      // console.log( res.data.x, res.data.y);
      // option.xAxis.data = res.data.x;
      option.series[0].data = res.data;
      option.series[1].data = res.data;
      myChart.setOption(option);
    });

    //饼图
    pieOption = {
      title: {
        text: "用户注册",
        subtext: "比例图",
        left: "center",
      },
      tooltip: {
        trigger: "item",
      },
      legend: {
        orient: "vertical",
        left: "left",
      },
      series: [
        {
          // name: "Access From",
          type: "pie",
          radius: "55%",
          center: ["50%", "60%"],
          data: [], // 数据图
           label: {
                normal: {
                    show: true,
                    formatter: '{b}: {c}({d}%)'
                }
            },
        },
      ],
    };
    let pieDom = document.getElementById("pie");
    let pieChart = echarts.init(pieDom);
    let pieOption;

    this.request.get("echarts/userMembers").then((res) => {
      pieOption.series[0].data = [
        { value: res.data[0], name: "第一季度" },
        { value: res.data[1], name: "第二季度" },
        { value: res.data[2], name: "第三季度" },
        { value: res.data[3], name: "第四季度" },
      ];
      pieChart.setOption(pieOption);
    });

     this.getGoodsNum();
  
  },
 
};
</script>

<style scoped>
#main {
  width: 500px;
  height: 400px;
}
</style>
