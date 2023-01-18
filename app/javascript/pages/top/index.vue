<template>
  <section class="top--part bg-cover bg-center md:bg-fixed">
    <div class="mx-auto h-96 flex flex-col justify-end relative">
      <div class="pb-16">
        <h1 class="text-4xl font-bold text-white text-center">カラダの中のビタミンCが見える</h1>
        <p class="text-white text-center">体に入ってくるビタミンが目でわかるから続けられる</p>
      </div>
    </div>
  </section>
  <section>
      <div class="mx-auto text-center pt-10">
        <BaseButton
          :bgcolor="'bg-sky-400 hover:bg-sky-500'"
          @click="goToGuestGraphPage"
          >
          使ってみる
        </BaseButton>
      </div>
  </section>
  <section>
    <!--
    <div class="mx-auto h-96 pt-10">
      <div>
        <h1 class="text-4xl font-bold text-center">使い方</h1>
      </div>
    </div>
  -->
  </section>
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
      this.$router.push({ path: '/guest_graph' })
    },
  }
}
</script> 

<style scoped>
.top--part {
  background-image: url('images/sapoc_top.png');
}
</style>
