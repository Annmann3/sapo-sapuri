<template>
  <Graph
    v-if="loaded"
    :chart-data="chartData"
    :nutrient-name="nutrient.name"
  />
</template>

<script>
import Graph from '../../components/TheChart'
import { mapActions, mapState } from 'vuex'

export default {
  name: 'GraphIndex',
  components: { Graph },
  data() {
    return {
      loaded: false, //グラフの描画が完了したかどうか
      chartData: [],
      nutrient: {id: 1, name: 'ビタミンC'},
    }
  },
  computed: {
    ...mapState({
      dosageList: state => state.dosages.dosageList,
      
    }),
  },
  async mounted() {
    this.loaded = false
    const datas = await this.getUserGraphData(this.nutrient.id)
    try {
      this.chartData = datas
        this.loaded = true
    } catch(err) {
      this.$store.commit('flashMessage/setFlashMessage',err)
    }
  },
  methods: {
    ...mapActions('graph', ['getUserGraphData']),
  },
}
</script>
