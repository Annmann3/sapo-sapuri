<template>
  <div class="min-h-screen w-full bg-gray-200 font-source-sans antialiased absolute">
    <TheHeader />
    <FlashMessage />
    <div class="content">
      <main class="mt-16">
        <router-view />
      </main>
    </div>
    <TheFooter />
  </div>
</template>

<script>
import TheHeader from './components/TheHeader.vue'
import FlashMessage from './components/FlashMessage.vue'
import TheFooter from './components/TheFooter.vue'

export default {
  components: {
    TheHeader,
    FlashMessage,
    TheFooter,
  },
  data: function () {
    return {
      message: "Hello Vue and ChartJS!"
    }
  }
}
</script>

<style scoped>
.content {
  display: flex;
  flex-direction: column;
  min-height: calc(100vh - 16rem); /* 16remはHeaderとFooterの高さ合計 */
  padding-bottom: 4rem; /* Footerの高さを確保 */
}

main {
  flex-grow: 1;
}

p {
  font-size: 2em;
  text-align: center;
}
</style>
