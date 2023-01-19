<template>
  <div class="min-h-screen w-full bg-gray-200 font-source-sans antialiased absolute">
    <TheHeader />
    <main class="mt-16">
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
