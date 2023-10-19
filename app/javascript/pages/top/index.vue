<template>
  <div>
    <section class="top--part bg-cover bg-center h-96 flex flex-col items-center justify-end relative">
      <div class="pb-16">
        <h1 class="text-4xl font-bold text-white">カラダの中のビタミンCが見える</h1>
        <p class="text-white">体に入ってくるビタミンが目でわかるから続けられる</p>
      </div>
    </section>


    <section class="text-center pt-10">
      <BaseButton
        :bgcolor="'bg-blue-400 hover-bg-blue-500'"
        @click="goToGuestGraphPage"
      >
        使ってみる
      </BaseButton>
    </section>
  </div>
</template>

<script>
import image from 'images/sapoc_top.png'
import BaseButton from 'components/BaseButton'

export default {
  name: 'TopIndex',
  components: {
    BaseButton,
  },
  data() {
    return {
      image: image
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
