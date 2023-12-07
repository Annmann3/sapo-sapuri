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

  <section class="mx-auto h-80 pt-10 shadow-md">
    <div>
      <p class="text-center text-xl text-gray-700 mt-4">
        どれだけ体にビタミンCが満たされているか一目でわかります。<br>
        (1回の服用)
      </p>
    </div>
  </section>

    <section class="bg-gray-200 py-10">
      <div class="container mx-auto">
        <h2 class="text-3xl font-bold text-gray-800 text-center mb-4">ユーザー登録すると</h2>
        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
          <div class="p-4 bg-gray-50 rounded border-4 border-double border-gray-600">
            <h3 class="text-xl font-semibold text-gray-700 mb-2">グラフが複数回の服用に対応</h3>
            <p class="text-gray-600">２４時間以内の血中濃度がわかります</p>
            <div class="flex justify-center">
              <img :src="imageGraph" alt="sapoc_graph" class="mt-4 w-2/3 md:1/2">
            </div>
          </div>
          <div class="p-4 bg-gray-50 rounded border-4 border-double border-gray-600">
            <h3 class="text-xl font-semibold text-gray-700 mb-2">LINE連携でもっと便利に</h3>
            <p class="text-gray-600">LINE上で服用グラフの確認が直ぐにできます</p>
            <div class="flex justify-center">
              <img :src="imageIphone" alt="phone_display" class="mt-4 w-2/3 md:1/2">
            </div>
          </div>
        </div>
      </div>
    </section>

  <section class="bg-gray-300 p-8 rounded-lg shadow-md my-8 text-center">
    <h1 class="text-xl font-bold text-gray-800 mb-4">注意事項</h1>
    <p class="text-gray-700">
      当アプリはビタミンCの摂取と血中濃度を関連付けて表示します。ただし、以下の点に注意してください
    </p>
    <ul class="list-disc text-left mx-auto w-full md:w-1/2 text-gray-700 mt-4">
      <li class="mb-2">
        当アプリの表示するグラフは、体内の血中ビタミンC濃度を正確に反映しているわけではありません。
      </li>
      <li class="mb-2">
        アプリ内の計算は、1コンパートメントモデルに基づいて行われています。個々の健康状態や体内状況によって異なる結果が得られる可能性があります。
      </li>
      <li>
        ビタミンCの服用は健康への効果を保証するものではありません。適切な食事や医療アドバイスと併用して健康を維持・向上させることが重要です。
      </li>
    </ul>
  </section>
</template>

<script>
import { mapActions } from 'vuex'
import TheChart from '../../components/TheChart'
import DosageForm from '../../components/DosageForm'
import imageGraph from 'images/graph_intro.png'
import imageIphone from 'images/iphone.png'

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
      },
      imageGraph: imageGraph,
      imageIphone: imageIphone,
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
    changeGraphParams(dosage) {
      debugger
      this.graphParams.dosage_at = dosage.dosage_at
      this.graphParams.amount = dosage.amount
      this.$gtag.event('draw_guest_graph', {
        event_category: 'engagement',
        event_label: 'draw_guest_graph'
      })
      this.fetchGraphData()
    },
  },
}
</script>
