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
            backgroundColor: 'rgb(238, 234, 189, 0.5)',
            borderColor: '#F8FD60',
            //曲線保管オプション。
            cubicInterpolationMode: 'monotone',
            fill: true,
            data: [...this.chartData],
            pointStyle: false,
            segment: {
              borderColor: ctx => down(ctx, 'rgb(0,0,0,0.2)'),
              borderDash: ctx => down(ctx, [5,5])
            }
          }
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

                  },
          },
          yAxis: {
            display: false,
           },
          potition: {x: '09:00'},
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
