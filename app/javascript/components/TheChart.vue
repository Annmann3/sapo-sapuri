<template>
  <div class="flex container">
    <Line :chart-data="chartData" />
  </div>
</template>
<script>
import { Line } from 'vue-chartjs'
import 'chart.js/auto'

export default {
  name: 'TheChart',
  components: { Line },
  data() {
    return {
      chartData: {}
    }
  },
  mounted: function() {
    this.chartData = {
        datasets: [
          {
            label: 'Vitamin C',
            backgroundColor: 'rgb(238, 234, 189, 0.5)',
            borderColor: '#F8FD60',
            cubicInterpolationMode: 'monotone',
            fill: true,
            data: [
              {
                x: '2022-02-01-13:05',
                y: 0
              },
              {
                x: '2022-02-01-13:10',
                y: 2
              },
              {
                x: '2022-02-01-13:15',
                y: 3
              }
            ]
          }
        ]
    }
  }
}
</script>
