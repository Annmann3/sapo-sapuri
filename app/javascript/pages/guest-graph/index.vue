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

  <section class="mx-auto h-96 pt-10 shadow-md">
    <div>
      <h1 class="text-4xl font-bold text-gray-700 text-center">使い方</h1>
      <p class="text-center text-gray-700 mt-4">
        ビタミンCの服用量と時間を記録。<br>
        どれだけ身体がビタミンCで満たされているか一目でわかります。<br>
      </p>
    </div>
  </section>

    <section class="bg-gray-300 p-8 rounded-lg shadow-md my-8">
      <h1 class="text-xl font-bold text-gray-800 text-center mb-4">注意事項</h1>
      <p class="text-gray-700 text-center">
        当アプリはビタミンCの摂取と血中濃度を関連付けて表示します。ただし、以下の点に注意してください：
      </p>
      <ul class="list-disc list-inside text-gray-700">
        <li>当アプリの表示するグラフは、体内の血中ビタミンC濃度を正確に反映しているわけではありません。</li>
        <li>アプリ内の計算は、1コンパートメントモデルに基づいて行われています。個々の健康状態や体内状況によって異なる結果が得られる可能性があります。</li>
        <li>ビタミンCの服用は健康への効果を保証するものではありません。適切な食事や医療アドバイスと併用して健康を維持・向上させることが重要です。</li>
      </ul>
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
        dosage_at: new Date(Date.now() - 4 * 60 * 60 * 1000), // 4 hours ago
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
    changeGraphParams(date, dosageAmount) {
      this.graphParams.dosage_at = date
      this.graphParams.amount = dosageAmount
      this.$gtag.event('draw_guest_graph', {
        event_category: 'engagement',
        event_label: 'draw_guest_graph'
      })
      this.fetchGraphData()
    },
  },
}
</script>
