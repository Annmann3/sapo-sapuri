<template>
  <div class="flex container">
    <Line :chart-data="chartData" />
  </div>
</template>
<script>
import 'chart.js/auto'
import { Line } from 'vue-chartjs'

export default {
  name: 'Chart',
  components: { Line },
  data() {
    return {
      chartData: {
        labels: [ 'January', 'February', 'March'],
        datasets: [
          {
            label: 'Data One',
            backgroundColor: '#f87979',
            data: [30, 20, 12]
          }
        ]
      },
      options: {
        animation: true,
        scaleLabel: {
          display: true,
          labelString: '月',
          fontColor: 'black',
          fontSize: 16
        },
        ticks: {
        }
      }
    }
  },
  mounted: function() {
    this.chartData = {
        labels: [ '13:00', '13:30', '14:00'],
        datasets: [
          {
            label: 'Nutrient',
            backgroundColor: 'rgb(238, 234, 189, 0.5)',
            borderColor: '#F8FD60',
            cubicInterpolationMode: 'monotone',
            fill: true,
            data: [90, 70, 60]
          }
        ]
    }
  }
}
</script>
