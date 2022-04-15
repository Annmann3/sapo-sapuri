<template>
  <div class="flex">
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
            data: [40, 20, 12]
          }
        ]
      }
    }
  }
}
</script>
