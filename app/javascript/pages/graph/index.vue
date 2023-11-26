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
        @caliculate="handleCreateDosage"
      />
    </div>
  </div>
  </section>
</template>

<script>
import TheChart from '../../components/TheChart'
import DosageForm from './DosageForm'
import { mapActions } from 'vuex'

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
  async mounted() {
    this.loaded = false
    try {
      const datas = await this.getUserGraphData(this.nutrient.id)
      this.chartData = datas
      this.loaded = true
    } catch(err) {
      this.$store.commit('flashMessage/setFlashMessage',err)
    }
  },
  methods: {
    ...mapActions('graph', ['getUserGraphData']),
    ...mapActions('dosages', ['createDosage']),
    async handleCreateDosage(dosage) {
      try {
        await this.$store.dispatch('dosages/createDosage', dosage)
        this.loaded = false
        const datas = await this.getUserGraphData(this.nutrient.id)
        this.chartData = datas
        this.loaded = true
      } catch(err) {
        this.$store.commit('flashMessage/setFlashMessage',err.response)
      }
    },
  },
}
</script>
