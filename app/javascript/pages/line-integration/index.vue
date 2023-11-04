<template>
  <link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css"
  >
  <div class="bg-blue-200 flex">
    <div class="flex-col flex ml-auto mr-auto items-center w-full">
      <h1 class="font-bold text-2xl my-10 text-white">
        ログイン LINE連携
      </h1>
      <form
        id="login-form"
        ref="loginForm"
        method="post"
        :action="loginUrl"
        class="mt-2 flex flex-col w-11/12"
        @submit.prevent="loginUser"
      >
        <div class="flex flex-wrap items-stretch w-full mb-4 relative h-15 bg-white items-center rounded mb-6 pr-10">
          <div class="flex -mr-px justify-center w-15 p-4">
            <span
              class="flex items-center leading-normal bg-white px-3 border-0 rounded rounded-r-none text-2xl text-gray-600"
            >
              <i class="fas fa-envelope" />
            </span>
          </div>
          <label for="email" />
          <input
            id="email"
            v-model="user.email"
            name="email"
            type="email"
            class="flex-shrink flex-grow flex-auto leading-normal w-px flex-1 border-0 h-10 border-grey-light rounded rounded-l-none px-3 self-center relative  font-roboto text-xl outline-none"
            placeholder="email"
          >
        </div>
        <div class="flex flex-wrap items-stretch w-full relative h-15 bg-white items-center rounded mb-4">
          <div class="flex -mr-px justify-center w-15 p-4">
            <span
              class="flex items-center leading-normal bg-white rounded rounded-r-none text-xl px-3 whitespace-no-wrap text-gray-600"
            >
              <i class="fas fa-lock" />
            </span>
          </div>
          <label for="password" />
          <input
            id="password"
            v-model="user.password"
            name="password"
            type="password"
            class="flex-shrink flex-grow flex-auto leading-normal w-px flex-1 border-0 h-10 px-3 relative self-center font-roboto text-xl outline-none"
            placeholder="Password"
          >
          <div class="flex -mr-px">
            <span
              class="flex items-center leading-normal bg-white rounded rounded-l-none border-0 px-3 whitespace-no-wrap text-gray-600"
            >
              <i class="fas fa-eye-slash" />
            </span>
          </div>
        </div>
        <input
          type="hidden"
          name="link_token"
          :value="linkToken"
        />
        <router-link
          :to="{ path: '/password' }"
          class="text-base text-white text-right font-roboto leading-normal hover:underline mb-6"
        >
          パスワードを忘れた場合
        </router-link>
        <router-link
          :to="{ path: '/register' }"
          class="text-base text-white text-right font-roboto leading-normal hover:underline mb-6"
        >
          新規登録
        </router-link>
        <button
          type="submit"
          class="bg-blue-400 py-4 text-center px-17 md:px-12 md:py-4 text-white rounded leading-tight text-xl md:text-base font-sans mt-4 mb-20"
        >ログイン</button>
      </form>
    </div>
  </div>
</template>

<script setup>
import { ref, computed} from 'vue'
import { useRoute } from 'vue-router'
import { useStore } from 'vuex'

const route = useRoute()
const store = useStore()
const user = ref({
  email: '',
  password: ''
})
const linkToken = route.query.linkToken
const loginForm = ref(null);


const loginUrl = computed(() => {
  const host = window.location.origin
  return `${host}/api/v1/line_integration`
})

// CORSのプリフライトリクエストのエラー回避のため、form要素を使ってPOSTリクエストを送る
// submit後の遷移を起こす前にuserを検証する
const loginUser = async () => {
  try {
    await store.dispatch('users/signin', user.value)
    if (loginForm.value) {
      loginForm.value.submit()
    }
  } catch(err) {
    store.commit('flashMessage/setFlashMessage', err.response)
  }
}

</script>
