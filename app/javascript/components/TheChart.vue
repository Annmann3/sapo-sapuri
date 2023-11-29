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
import { Chart } from 'chart.js'
import 'chart.js/auto'
import 'chartjs-adapter-moment'
import annotationPlugin from 'chartjs-plugin-annotation'

Chart.register(annotationPlugin)

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
    goalData: {
      type: Object,
      required: false,
      default() {
        return {
          x: null,
          y: 0,
        }
      }
    }
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
        // 横軸の目安線
        plugins: {
          annotation: {
            annotations: [
              {
                type: 'line',
                mode: 'horizontal',
                scaleID: 'yAxis',
                value: this.goalData.y,
                borderColor: 'black',
                borderWidth: 1,
                label: {
                  display: true,
                  content: '基準ライン',
                  backgroundColor: 'gray',
                  position: 'start'
                },
              },
              // 現在時刻の値
              {
                type: 'line',
                mode: 'horizontal',
                scaleID: 'yAxis',
                value: 0,
                borderColor: 'green',
                borderWidth: 2,
                label: {
                  display: true,
                  content: '',
                  backgroundColor: 'blue',
                  opacity: 0.1
                }
              }
            ]
          }
        },
      },
    currentValue: {},
    }
  },
  mounted() {
    this.chartObj.datasets[0].data = this.sortChartData(this.chartData)
    this.chartObj.datasets[1].data = [{x: new Date(), y: Math.max(...this.chartData.map(d => d.y))}];
    this.checkGoal()
  },
  methods: {
    sortChartData(data) {
      // chartDataをxキー（時刻）でソートし、日付オブジェクトとして扱えるようにする
      return data.slice().sort((a, b) => {
        return new Date(a.x) - new Date(b.x)
      })

    },
    checkGoal() {
      if (!this.goalData.y) return
      const goalData = this.goalData.y;

      const chartDataSet = this.chartObj.datasets[0].data;
      const currentTimeStamp = Math.floor(Date.now() / 1000);
      // 現在時刻に最も近い値のデータを探する
      const currentDataPoint = chartDataSet.reduce((closest, data) => {
        const dataTimeStamp = Math.floor(new Date(data.x).getTime() / 1000)
        const closestTimeStamp = Math.floor(new Date(closest.x).getTime() / 1000)
        return Math.abs(currentTimeStamp - dataTimeStamp) < Math.abs(currentTimeStamp - closestTimeStamp) ? data : closest

      }, chartDataSet[0])

      const isGoalExceeded = currentDataPoint.y < goalData
      const goalAnnotaion = this.chartOptions.plugins.annotation.annotations[1]
      const currentValue = currentDataPoint.y
      if (isGoalExceeded) {
        goalAnnotaion.borderColor = 'red'
        goalAnnotaion.label.content = '不足'
        goalAnnotaion.label.backgroundColor = 'red'
        goalAnnotaion.value = currentValue
      } else {
        goalAnnotaion.borderColor = 'black'
        goalAnnotaion.label.content = 'Good!!'
        goalAnnotaion.label.backgroundColor = 'green'
        goalAnnotaion.value = currentValue

      }
    },
  },
}
</script>
