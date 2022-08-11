<template>
  <link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css"
  >
  <div class="bg-blue-200 flex">
    <div class="flex-col flex ml-auto mr-auto items-center w-full">
      <h1 class="font-bold text-2xl my-10 text-white">
        パスワード変更
      </h1>
      <form
        action=""
        class="mt-2 flex flex-col w-11/12"
      >
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
            type="password"
            class="flex-shrink flex-grow flex-auto leading-normal w-px flex-1 border-0 h-10 px-3 relative self-center font-roboto text-xl outline-none"
            placeholder="新しいパスワード"
          >
          <div class="flex -mr-px">
            <span
              class="flex items-center leading-normal bg-white rounded rounded-l-none border-0 px-3 whitespace-no-wrap text-gray-600"
            >
              <i class="fas fa-eye-slash" />
            </span>
          </div>
        </div>
        <div class="flex flex-wrap items-stretch w-full relative h-15 bg-white items-center rounded mb-4">
          <div class="flex -mr-px justify-center w-15 p-4">
            <span
              class="flex items-center leading-normal bg-white rounded rounded-r-none text-xl px-3 whitespace-no-wrap text-gray-600"
            > 
              <i class="fas fa-lock" />
            </span>
          </div>
          <label for="password_confirmation" />
          <input
            id="password_confirmation"
            v-model="user.password_confirmation"
            type="password"
            class="flex-shrink flex-grow flex-auto leading-normal w-px flex-1 border-0 h-10 px-3 relative self-center font-roboto text-xl outline-none"
            placeholder="新しいパスワード(確認)"
          >
          <div class="flex -mr-px">
            <span
              class="flex items-center leading-normal bg-white rounded rounded-l-none border-0 px-3 whitespace-no-wrap text-gray-600"
            >
              <i class="fas fa-eye-slash" />
            </span>
          </div>
        </div>
        <a
          href="#"
          class="text-base text-white text-right font-roboto leading-normal hover:underline mb-6"
        >Forget Password ?</a>
        <button
          type="button"
          class="bg-blue-400 py-4 text-center px-17 md:px-12 md:py-4 text-white rounded leading-tight text-xl md:text-base font-sans mt-4 mb-20"
          @click="sendPassword"
        >
          パスワードリセット
        </button>
      </form>
    </div>
  </div>
</template>

<script>
import { mapActions } from 'vuex'

export default {
  name: 'ResetPassword',
  data() {
    return {
      user: {
        password: "",
        password_confirmation: "",
      }
    }
  },
  methods: {
    ...mapActions('users', ['updatePassword']),
    async sendPassword() {
      try {
        // パスワードリセットに必要なパラメータを取得
        const urlParams = this.$route.query
        const headers = {
          'access-token': urlParams['access-token'],
          'uid': urlParams['uid'],
          'client': urlParams['client'],
        }
        await this.updatePassword({user: this.user, headers: headers})
        this.$router.push({ path: '/' })
      } catch(error) {
        console.log(error)
      }
    }
  }
}
</script>
