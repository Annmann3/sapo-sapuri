<template>
  <footer class="bg-transparent text-gray-700 py-4">
    <div class="container mx-auto flex flex-col md:flex-row items-center justify-between px-4">
      <ul class="flex space-x-3 md:space-x-4">
        <li class="mb-0 md:mb-2"><router-link to="/terms" class="text-gray-700 text-sm ">利用規約</router-link></li>
        <li><router-link to="/privacy-policy" class="text-gray-700 text-sm">プライバシポリシー</router-link></li>
        <li><router-link to="/notes" class="text-gray-700 text-sm">注意事項</router-link></li>
        <li><a href="https://docs.google.com/forms/d/e/1FAIpQLSecvyGVJm10hXeMhOgVCUgVqJIcT1b8z48fAbDnhUb-hC5-UA/viewform?usp=sf_link" class="text-gray-700 text-sm" target="_blank">お問い合わせ</a></li>
      </ul>
      <div class="mb-2 md:mb-0">
        <p class="text-sm font-semibold">&copy;  サポC 2023</p>
      </div>
    </div>
  </footer>
</template>
