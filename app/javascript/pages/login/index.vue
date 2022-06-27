<template>
  <!-- This is an example component -->
  <link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css"
  >
  <div class="bg-blue-200 flex">
    <div class="flex-col flex ml-auto mr-auto items-center w-full lg:w-2/3 md:w-3/5">
      <h1 class="font-bold text-2xl my-10 text-white">
        ログイン
      </h1>
      <form
        action=""
        class="mt-2 flex flex-col lg:w-1/2 w-8/12"
      >
        <div class="flex flex-wrap items-stretch w-full mb-4 relative h-15 bg-white items-center rounded mb-6 pr-10">
          <div class="flex -mr-px justify-center w-15 p-4">
            <span
              class="flex items-center leading-normal bg-white px-3 border-0 rounded rounded-r-none text-2xl text-gray-600"
            >
              <i class="fas fa-user-circle" />
            </span>
          </div>
          <input
            type="text"
            class="flex-shrink flex-grow flex-auto leading-normal w-px flex-1 border-0 h-10 border-grey-light rounded rounded-l-none px-3 self-center relative  font-roboto text-xl outline-none"
            placeholder="Username"
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
          <input
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
        <a
          href="#"
          class="text-base text-white text-right font-roboto leading-normal hover:underline mb-6"
        >Forget Password ?</a>
        <a
          href="/"
          class="bg-blue-400 py-4 text-center px-17 md:px-12 md:py-4 text-white rounded leading-tight text-xl md:text-base font-sans mt-4 mb-20"
          @click="loginUser"
        >
          ログイン
        </a>
      </form>
    </div>
  </div>


  <section
    class="absolute top-1/2 left-1/2 mx-auto max-w-sm -translate-x-1/2 -translate-y-1/2 transform space-y-4 text-center"
  >
    <!-- register content -->
    <div
      x-show="isLoginPage"
      class="space-y-4"
    >
      <header class="mb-3 text-2xl font-bold">
        Create your profile
      </header>
      <div class="w-full rounded-2xl bg-gray-50 px-4 ring-2 ring-gray-200 focus-within:ring-blue-400">
        <input
          type="text"
          placeholder="Age"
          class="my-3 w-full border-none bg-transparent outline-none focus:outline-none"
        >
      </div>
      <div class="w-full rounded-2xl bg-gray-50 px-4 ring-2 ring-gray-200 focus-within:ring-blue-400">
        <input
          type="text"
          placeholder="Name (optional)"
          class="my-3 w-full border-none bg-transparent outline-none focus:outline-none"
        >
      </div>
      <div class="w-full rounded-2xl bg-gray-50 px-4 ring-2 ring-gray-200 focus-within:ring-blue-400">
        <input
          type="text"
          placeholder="Email"
          class="my-3 w-full border-none bg-transparent outline-none focus:outline-none"
        >
      </div>
      <div class="w-full rounded-2xl bg-gray-50 px-4 ring-2 ring-gray-200 focus-within:ring-blue-400">
        <input
          type="password"
          placeholder="Password"
          class="my-3 w-full border-none bg-transparent outline-none focus:outline-none"
        >
      </div>
      <button
        class="w-full rounded-2xl border-b-4 border-b-blue-600 bg-blue-500 py-3 font-bold text-white hover:bg-blue-400 active:translate-y-[0.125rem] active:border-b-blue-400"
      >
        CREATE ACCOUNT
      </button>
    </div>

    <!-- login content -->
    <div
      x-show="!isLoginPage"
      class="space-y-4"
    >
      <header class="mb-3 text-2xl font-bold">
        Log in
      </header>
      <div class="w-full rounded-2xl bg-gray-50 px-4 ring-2 ring-gray-200 focus-within:ring-blue-400">
        <input
          type="text"
          placeholder="Email or username"
          class="my-3 w-full border-none bg-transparent outline-none focus:outline-none"
        >
      </div>
      <div
        class="flex w-full items-center space-x-2 rounded-2xl bg-gray-50 px-4 ring-2 ring-gray-200 focus-within:ring-blue-400"
      >
        <input
          type="password"
          placeholder="Password"
          class="my-3 w-full border-none bg-transparent outline-none"
        >
        <a
          href="#"
          class="font-medium text-gray-400 hover:text-gray-500"
        >FORGOT?</a>
      </div>
      <button
        class="w-full rounded-2xl border-b-4 border-b-blue-600 bg-blue-500 py-3 font-bold text-white hover:bg-blue-400 active:translate-y-[0.125rem] active:border-b-blue-400"
      >
        LOG IN
      </button>
    </div>

    <div class="flex items-center space-x-4">
      <hr class="w-full border border-gray-300">
      <div class="font-semibold text-gray-400">
        OR
      </div>
      <hr class="w-full border border-gray-300">
    </div>

    <footer>
      <div class="grid grid-cols-2 gap-4">
        <a
          href="#"
          class="rounded-2xl border-b-2 border-b-gray-300 bg-white py-2.5 px-4 font-bold text-blue-700 ring-2 ring-gray-300 hover:bg-gray-200 active:translate-y-[0.125rem] active:border-b-gray-200"
        >FACEBOOK</a>
        <a
          href="#"
          class="rounded-2xl border-b-2 border-b-gray-300 bg-white py-2.5 px-4 font-bold text-blue-500 ring-2 ring-gray-300 hover:bg-gray-200 active:translate-y-[0.125rem] active:border-b-gray-200"
        >GOOGLE</a>
      </div>

      <div class="mt-8 text-sm text-gray-400">
        By signing in to ********, you agree to our
        <a
          href="#"
          class="font-medium text-gray-500"
        >Terms</a> and
        <a
          href="#"
          class="font-medium text-gray-500"
        >Privacy Policy</a>.
      </div>
    </footer>
  </section>
</template>

<script>
import { mapActions } from "vuex"

export default {
  name: "LoginIndex",
  methods: {
    ...mapActions('users',["login"]),
    async loginUser() {
      try {
        await this.login(this.user)
      } catch (error) {
        console.log(error)
      }
    }
  }
}
</script>
