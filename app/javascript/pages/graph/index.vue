<template>
  <Graph
    v-if="loaded"
    :chart-data="chartData"
    :nutrient-name="nutrient.name"
  />
</template>

<script>
import Graph from '../../components/TheChart'
import { mapActions } from 'vuex'

export default {
  name: 'GraphIndex',
  components: { Graph },
  data() {
    return {
      loaded: false, //グラフの描画が完了したかどうか
      chartData: [],
      nutrient: {}
    }
  },
  async mounted() {
    this.loaded = false
    try {
      this.nutrient = {id: 1, name: 'ビタミンC'}
      let arr = []
      const datas = await this.getNutrinetData(this.nutrient.id)
      for (let n=0; n<24; n++) {
        arr.push(datas[n * 60])
      }
      
      this.chartData = arr
      this.loaded = true
    } catch(error) {
      console.log(error)
    }
  },
  methods: {
    ...mapActions('graph', ['getNutrinetData']),
  },
}
</script>
