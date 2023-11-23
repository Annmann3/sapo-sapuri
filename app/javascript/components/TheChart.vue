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

const isFuture = (ctx, value) => ctx.p0.parsed.x > new Date() ? value : undefined

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
            backgroundColor: 'rgb(238, 234, 189, 0.9)',
            borderColor: '#F8FD60',
            cubicInterpolationMode: 'monotone',
            fill: true,
            data: [], // データはここにセットする
            pointStyle: 'dash',
            order: 2,
            segment: {
              // 未来区間のスタイル
              borderColor: ctx => isFuture(ctx, 'rgb(0,0,0,0.2)'),
              backgroundColor: ctx => isFuture(ctx, 'rgb(0,0,0,0.1)'),
              borderDash: ctx => isFuture(ctx, [5,5])
            }
          },
          {
            type: 'bar',
            label: '現在時刻',
            backgroundColor: 'rgba(255, 99, 132, 0.9)',
            borderColor: 'rgb(201, 203, 207)',
            barPercentage: 0.1,
            order: 0,
            data: [{x: new Date(), y: 0}],  // 初期値
          },
        ]
      },
      chartOptions: {
        responsive: true,
        scales: {
          xAxis: {
            type: 'time',
            time: {
              stepSize: 1,
              displayFormats: {
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
            beginAtZero: true,
            title: {
              display: true,
              text: '血中濃度 (mg/L)',
              textColor: 'rgb(235, 235, 235)'
            },
          },
        },
      },
    }
  },
  mounted() {
    this.chartObj.datasets[0].data = this.sortChartData(this.chartData)
    this.chartObj.datasets[1].data = [{x: new Date(), y: Math.max(...this.chartData.map(d => d.y))}];
  },
  methods: {
    sortChartData(data) {
      // chartDataをxキー（時刻）でソートし、日付オブジェクトとして扱えるようにする
      return data.slice().sort((a, b) => {
        return new Date(a.x) - new Date(b.x)
      })
    },
  },
}
</script>

