<template>
  <section class="mx-auto">
  <div class="flex flex-wrap justify-center items-stretch">
    <TheChart
      v-if="loaded"
      :chart-data="chartData"
      :nutrient-name="nutrient.name"
    />
    <div class="self-center mt-6 md:mt-0 md:ml-6">
      <DosageForm
        @caliculate="changeGraphParams"
      />
    </div>
  </div>
  </section>
</template>

<script>
import TheChart from '../../components/TheChart'
import DosageForm from './DosageForm'
import { mapActions, mapState } from 'vuex'

export default {
  name: 'GraphIndex',
  components: { TheChart, DosageForm },
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
