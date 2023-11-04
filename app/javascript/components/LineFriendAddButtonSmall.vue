<template>
<div class="line-it-button" data-lang="ja" data-type="friend" data-env="REAL" data-lineId="@433onjos" style="display: none;"></div>
</template>

<script setup>
import { ref, onMounted } from 'vue'

onMounted(() => {
  const script = document.createElement('script')
  script.src = 'https://www.line-website.com/social-plugins/js/thirdparty/loader.min.js'
  script.async = true
  script.defer = true
  document.body.appendChild(script)
})
</script>
