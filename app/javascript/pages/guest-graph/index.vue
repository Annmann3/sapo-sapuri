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
        @caliculate="changeDosageAt"
      />
    </div>
  </div>
  </section>
  <section>
  </section>
</template>

<script>
import { mapActions } from 'vuex'
import TheChart from '../../components/TheChart'
import DosageForm from './DosageForm'

export default {
  name: 'GuestGraphIndex',
  components: { TheChart, DosageForm },
  data() {
    return {
      loaded: false,
      chartData: [],
      nutrient: {id: 1, name: 'ビタミンC'},
      graphParams: {
        dosage_at: new Date(),
        nutrient_id: 1,
        amount: 500,
      }
    }
  },
  async mounted() {
    this.fetchGraphData()
  },
  methods: {
    ...mapActions('graph', ['getGuestGraphData']),
    async fetchGraphData() {
      this.loaded = false
      try {
        this.chartData = await this.getGuestGraphData(this.graphParams)
        this.loaded = true
      } catch(error) {
        console.log(error)
      }
    },
    changeDosageAt(date) {
      this.graphParams.dosage_at = date
      this.fetchGraphData()
    },
  },
}
</script>
