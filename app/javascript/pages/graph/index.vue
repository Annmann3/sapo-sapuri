<template>
  <section class="mx-auto">
  <div class="flex flex-wrap justify-center items-stretch">
    <TheChart
      v-if="loaded"
      :chart-data="chartData"
      :nutrient-name="nutrient.name"
      :goal-data="goalData"
    />
    <div class="self-center mt-6 md:mt-0 md:ml-6">
      <DosageForm
        @caliculate="handleCreateDosage"
      />
    </div>
  </div>
  </section>

  <section v-if="loaded" class="max-auto mt-10">
    <div class="my-8">
    <h3 class="text-3xl font-bold text-gray-800 text-center my-4">１週間の達成率</h3>
    <the-gauge
        :achievement-rate="achievementRate"
        />
      <p class="text-xl font-bold text-gray-800 text-center my-4">基準ラインより上を維持しよう</p>
    </div>
    <div v-if="goalData.x" class="my-8">
      <p class="text-xl font-bold text-gray-800 text-center mb-4">{{ goalTime }} までに飲めば目標達成!!</p>
    </div>
  </section>
</template>

<script>
import TheChart from '../../components/TheChart'
import DosageForm from './DosageForm'
import TheGauge from '../../components/TheGauge'
import { mapActions, mapGetters } from 'vuex'

export default {
  name: 'GraphIndex',
  components: { TheChart, DosageForm, TheGauge},
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
  computed: {
    ...mapGetters({
      achievementRate: 'graph/achievementRate',
      goalData: 'graph/goalData',
    }),
    goalTime() {
      if (!this.goalData.x) return null

      const goalTime = this.goalData.x
      const day = goalTime.split('T')[0].slice(8,10)
      const goalHour = goalTime.split('T')[1].slice(0,2)
      const goalMinute = goalTime.split('T')[1].slice(3,5)
      return `${day}日 ${goalHour}:${goalMinute}`
    },
  },
  methods: {
    ...mapActions({
      getUserGraphData: 'graph/getUserGraphData',
      createDosage: 'dosages/createDosage',
    }),
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
