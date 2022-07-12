<template>
  <div class="min-h-screen bg-gray-200 font-source-sans antialiased flex top-0">
    <TheHeader />
    <main class="container mx-auto mt-28 px-5">
      <router-view />
    </main>
  </div>
</template>

<script>
import TheHeader from './components/TheHeader.vue'
export default {
  components: {
    TheHeader,
  },
  data: function () {
    return {
      message: "Hello Vue and ChartJS!"
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
