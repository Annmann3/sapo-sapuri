<template>
  <div class="flex">
    <Line
      :chart-data="chartObj"
      :chart-options="chartOptions"
    />
  </div>
</template>
<script>
import { Line } from 'vue-chartjs'
import 'chart.js/auto'
import 'chartjs-adapter-moment'

//減少区間
const down = (ctx, value) => ctx.p0.parsed.y > ctx.p1.parsed.y ? value : undefined
// 現在時刻移行
const now = (ctx, value) => ctx.p0.parsed.x > new Date() ? value : undefined
const now2 = function(ctx, value) {
    if (ctx.p0.parsed.x < new Date() && ctx.p1.parsed.x > new Date()) {
      debugger
      ctx.p0.draw()
    }
  return ctx.p0.parsed.x > new Date() ? value : undefined
}

export default {
  name: 'TheChart',
  components: { Line },
  props: {
    chartData: {
      type: Array,
      required: true,
    },
    nutrientName: {
      type: String,
      required: true,
    },
    options: {
      type: Object,
      default() {
        return {
        }
      },
    },
  },
  data() {
    return {
      chartObj: {
        datasets: [
          {
            label: this.nutrientName,
            backgroundColor: 'rgb(238, 234, 189, 0.8)',
            borderColor: '#F8FD60',
            cubicInterpolationMode: 'monotone',//曲線補完オプション。
            fill: true,
            data: [...this.chartData],
            pointStyle: false,
            order: 1, //描画順序
            segment: {
              borderColor: ctx => now(ctx, 'rgb(0,0,0,0.2)'),
              backgroundColor: ctx => now(ctx, 'rgb(0,0,0,0.1)'),
              borderDash: ctx => now(ctx, [5,5])
            }
          },
          {
            // 現在時刻の縦線
            type: 'bar',
            label: '現在時刻',
            backgroundColor: 'rgba(255, 99, 132, 0.9)',
            borderColor: 'rgb(201, 203, 207)',
            barPercentage: 0.1,
            order: 0,
            data: [{x: new Date(), y: Math.max(...this.chartData.map(d => d.y))}],  // 値は最大値に合わせる
          },
        ]
      },
      chartOptions: {
        scales: {
          xAxis: {
            type: 'time',
            time: {
              stepSize: 1,
              displayFormats:{
                hour: 'HH:mm',
              },
              ticks: {
                source: 'data',
                autoSkip: true,
                maxTicksLimit: 24,
                color: 'rgb(235, 235, 235)',
              },
            },
          },
          yAxis: {
            display: false,
            beginAtZero: true,
           },
        },
        animations: {
          tension: {
            duration: 900,
            easing: 'easeInQuad',
            from: 1,
            to: 0,
            loop: true,
          },
        },
      },
    }
  },
  mounted() {
    console.log('hello')
  }
}
</script>
