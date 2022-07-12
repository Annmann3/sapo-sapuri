<template>
  <header class="text-gray-600 body-font">
    <div class="mx-auto flex flex-col items-center">
      <nav class="fixed top-0 left-0 w-full h-16 transition duration-500 ease-in-out bg-yellow-200 shadow-sm lg:shadow-none">
        <div class="relative max-w-screen-xl px-2 mx-auto bg-yellow-200 shadow-sm sm:px-4 lg:px-8 lg:shadow-none">
          <div class="relative flex items-center justify-between h-16">
            <div class="flex items-center flex-shrink-0 nuxt-link-exact-active nuxt-link-active">
              <router-link
                :to="{ path: '/' }"
              >
                Sapo-Sapuri
              </router-link>
            </div>
            <div class="hidden lg:block lg:ml-4" />
            <router-link
              :to="{ path: '/login' }"
            >
              ログイン
            </router-link>
          </div>
        </div>
      </nav>
    </div>
  </header>
</template>

<script>

export default {
  name: 'TheHeader',
}
</script>
