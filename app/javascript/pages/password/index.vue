<template>
  <!-- This is an example component -->
  <link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css"
  >
  <div class="bg-blue-200 flex">
    <div class="flex-col flex ml-auto mr-auto items-center w-full">
      <h1 class="font-bold text-2xl my-10 text-white">
        パスワードリセット
      </h1>
      <div
        v-if="isSentEmail"
        class="mt-2 flex flex-col w-11/12"
      >
        <p
          class="font-bold text-2xl my-10 text-white"
        >
          メールアドレスにパスワード変更用URLを送信しました。
        </p>
        <button
          type="button"
          class="bg-blue-400 py-4 text-center px-17 md:px-12 md:py-4 text-white rounded leading-tight text-xl md:text-base font-sans mt-4 mb-20"
          @click="moveTopPage"
        >
          戻る
        </button>
      </div>
      <form
        v-else
        action=""
        class="mt-2 flex flex-col w-11/12"
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
            type="email"
            class="flex-shrink flex-grow flex-auto leading-normal w-px flex-1 border-0 h-10 border-grey-light rounded rounded-l-none px-3 self-center relative  font-roboto text-xl outline-none"
            placeholder="email"
          >
        </div>
        <button
          type="button"
          class="bg-blue-400 py-4 text-center px-17 md:px-12 md:py-4 text-white rounded leading-tight text-xl md:text-base font-sans mt-4 mb-20"
          @click="sendEmail"
        >
          送信
        </button>
      </form>
    </div>
  </div>
</template>

<script>
import { mapActions } from 'vuex'

export default {
  name: 'ResetPasswordIndex',
  data() {
    return {
      user: {
        email: '',
      },
      redirect_url: '',
      isSentEmail: false,
    }
  },
  mounted() {
    const origin = window.location.origin
    this.redirect_url = `${origin}/password/edit`
  },
  methods: {
    ...mapActions('users', ['resetPasswordMail']),
    async sendEmail() {
      try {
        await this.$store.dispatch('users/resetPasswordMail', { user: this.user, redirect_url: this.redirect_url })
        this.isSentEmail = true
      } catch(err) {
        this.$store.commit('flashMessage/setFlashMessage',err.response)
      }
    },
    moveTopPage() {
      this.$router.push({ path: '/' })
    }
  },
}
</script>
