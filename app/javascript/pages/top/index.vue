<template>
  <div>
    <section class="top--part bg-cover bg-center h-96 flex flex-col items-center justify-end relative">
      <div class="pb-16">
        <h1 class="text-4xl font-bold text-white">カラダの中のビタミンCが見える</h1>
        <p class="text-white">体に入ってくるビタミンが目でわかるから続けられる</p>
      </div>
    </section>


    <section v-if="!authUser" class="text-center py-10">
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
          <h3 class="text-xl font-semibold text-gray-700 mb-2">服用したビタミンCを記録できます</h3>
          <p class="text-xl text-gray-600">

          飲んだビタミンCをこのアプリで手軽に記録できます。<br>
          ビタミンCは水に溶けやすい性質があるので、1日に何度か分けて飲むと効果的です。<br>
          毎日続けて摂ることで、ビタミンCをしっかりと満たしましょう。<br>
          </p>
        </div>
        <div class="p-4 bg-gray-50 rounded border-4 border-double border-gray-600 text-xl">
          <h3 class="font-semibold text-gray-700 mb-2">LINE連携</h3>
          <p class="text-gray-600">LINEから手軽に服用を記録、グラフの確認をすることができます。</p>
          <p class="text-gray-600">ユーザー登録後に公式アカウントから連携することができます。</p>
        </div>
        <div class="flex-grow p-4 bg-gray-50 rounded border-4 border-double border-gray-600 text-xl">
          <h3 class="text-xl font-semibold text-gray-700 mb-2">ビタミンCの吸収量をグラフで確認できる</h3>
          <p class="text-gray-600">
          体にビタミンCがどれくらい満たされているのか、グラフでひと目で確認できます。</p>
        </div>
      </div>
    </section>

    
    <section class="bg-gray-200 py-10">
      <div class="container mx-auto">
        <h2 class="text-3xl font-bold text-gray-800 text-center mb-4">ビタミンCについて</h2>
      </div>
      <div class="container mx-auto flex items-start grid grid-cols-1 md:grid-cols-2 gap-8 mt-3">
        <div class="p-4 bg-gray-50 rounded border-4 border-double border-gray-600 text-xl">
          <h3 class="font-semibold text-gray-700 mb-2">ビタミンCって何?</h3>
          <p class="text-gray-600">
          ビタミンCは、抗酸化作用があり、コラーゲンの合成に不可欠な栄養素です。
          ビタミンCは体内で合成できないため、食事やサプリメントから摂取する必要があります。
          </p>
        </div>
        <div class="p-4 bg-gray-50 rounded border-4 border-double border-gray-600 text-xl">
          <h3 class="font-semibold text-gray-700 mb-2">どれくらいとればいいの?</h3>
          <p class="text-gray-600">
          1日に必要なビタミンCの量は、100mg。<br>
          美容を意識するなら、1日に1000mg以上。<br>
          多くのサプリメント製品では1回の摂取量が500mgなので、1日に２回以上摂っていきましょう。<br>
          </p>
        </div>
        <div class="p-4 bg-gray-50 rounded border-4 border-double border-gray-600">
          <h3 class="text-xl font-semibold text-gray-700 mb-2">ビタミンCの効果</h3>
          <ul class="list-disc text-xl text-gray-700 ml-4">
            <li class="mb-2">
              コラーゲンの生成を助ける
            </li>
            <li class="mb-2">
              美肌効果
            </li>
            <li class="mb-2">
              疲労回復
            </li>
            <li class="mb-2">
              抗酸化作用
            </li>
            <li class="mb-2">
              免疫力アップ
            </li>
            <p class="text-gray-600 ">
            ...etc
            </p>

          </ul>
        </div>
      </div>
    </section>


    <section v-if="!authUser" class="bg-gray-200 py-10">
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
  computed: {
    authUser() {
      return this.$store.getters['users/authUser']
    },
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
