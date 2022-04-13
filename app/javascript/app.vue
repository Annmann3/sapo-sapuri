<template>
  <div id="app">
    <p>{{ message }}</p>
  </div>
  <TheChart />
</template>

<script>
import TheChart from './packs/components/TheChart'
export default {
  components: {
  TheChart
  },
  data: function () {
    return {
      message: "Hello Vue and ChartJS!"
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
