<template>
  <div>
    <section class="top--part bg-cover bg-center h-96 flex flex-col items-center justify-end relative">
      <div class="pb-16">
        <h1 class="text-4xl font-bold text-white">カラダの中のビタミンCが見える</h1>
        <p class="text-white">体に入ってくるビタミンが目でわかるから続けられる</p>
      </div>
    </section>


    <section class="text-center py-10">
      <BaseButton
        :bgcolor="'bg-blue-400 hover:bg-blue-500'"
        @click="goToGuestGraphPage"
      >
        使ってみる
      </BaseButton>
    </section>


    <section class="bg-gray-200 py-10">
      <div class="container mx-auto">
        <h2 class="text-3xl font-bold text-gray-800 text-center mb-4">サポCでできること</h2>
      </div>
      <div class="container mx-auto flex items-start grid grid-cols-1 md:grid-cols-2 gap-8 mt-3">
        <div class="p-4 bg-gray-50 rounded border-4 border-double border-gray-600">
          <h3 class="text-xl font-semibold text-gray-700 mb-2">服用履歴を管理できます</h3>
          <p class="text-xl text-gray-600">
          飲んだビタミンCを記録することができます。<br>
          ビタミンCは水溶性のため、継続して取らないと排出されてしまいます。<br>
          一日に複数回に分けて取ることで、体にビタミンを満たしましょう<br>
          </p>
        </div>
        <div class="p-4 bg-gray-50 rounded border-4 border-double border-gray-600 text-xl">
          <h3 class="font-semibold text-gray-700 mb-2">LINE連携</h3>
          <p class="text-gray-600">飲んだらすぐに記録してグラフの確認をすることができます。</p>
          <p class="text-gray-600">ユーザー登録後に公式アカウントから連携することができます</p>
        </div>
        <div class="flex-grow p-4 bg-gray-50 rounded border-4 border-double border-gray-600 text-xl">
          <h3 class="text-xl font-semibold text-gray-700 mb-2">飲んだビタミンCの血中濃度がわかる</h3>
          <p class="text-gray-600">どれだけビタミンCで満たされているかグラフでわかります。</p>
        </div>
      </div>
    </section>


    <section class="bg-gray-200 py-10">
      <div class="container mx-auto text-center">
        <h2 class="text-3xl font-bold text-gray-800 mb-4">こんな人におすすめ</h2>
      <div class="container mx-auto mt-3 bg-gray-50 text-center md:w-1/2 border-4 border-double border-black border-opacity-50">
        <ul class="text-xl text-gray-600 font-bold">
          <li>美容のためにビタミンCを常に補給してるひと</li>
          <li>実感がなくて気づいたら飲むの忘れちゃうひと</li>
        </ul>
      </div>
      </div>
    </section>

  </div>
</template>

<script>
import imageTop from 'images/sapoc_top.png'
import BaseButton from 'components/BaseButton'

export default {
  name: 'TopIndex',
  components: {
    BaseButton,
  },
  data() {
    return {
      imageTop: imageTop,
    }
  },
  methods: {
    goToGuestGraphPage() {
      this.$router.push({ path: '/guest-graph' })
    },
  }
}
</script> 

<style scoped>
.top--part {
  background-image: url('images/sapoc_top.png');
}
</style>
