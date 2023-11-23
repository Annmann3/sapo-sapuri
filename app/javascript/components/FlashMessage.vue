<template>
<div v-if="isShowFlashMessage" :class="messageTypeClass" class="bg-opacity-50 px-4 py-3 mt-16 rounded fixed w-full z-11" role="alert">
  <strong class="font-bold">{{ messageTitle }}</strong>
  <ul>
    <li v-for="message in messages" :key="message">{{ message }}</li>
  </ul>
  <span class="absolute top-0 bottom-0 right-0 px-4 py-3" @click="closeFlashMessage">
    <svg class="fill-current h-6 w-6 text-white-500" role="button" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><title>Close</title><path d="M14.348 14.849a1.2 1.2 0 0 1-1.697 0L10 11.819l-2.651 3.029a1.2 1.2 0 1 1-1.697-1.697l2.758-3.15-2.759-3.152a1.2 1.2 0 1 1 1.697-1.697L10 8.183l2.651-3.031a1.2 1.2 0 1 1 1.697 1.697l-2.758 3.152 2.758 3.15a1.2 1.2 0 0 1 0 1.698z"/></svg>
  </span>
</div>
</template>

<script>

export default {
  computed: {
    isShowFlashMessage() {
      return this.$store.state.flashMessage.isFlashMessage
    },
    messageTypeClass() {
      // 成功/エラーメッセージに応じてクラスを設定
      return this.$store.state.success ? 'bg-green-100 border border-green-400 text-green-700' : 'bg-red-100 border border-red-400 text-red-700';
    },
    messageTitle() {
      // 成功/エラーメッセージのタイトルを設定
      if(this.$store.state.flashMessage.success) {
        return '成功'
      } else {
        return 'エラー'
      }
    },
    messages() {
      return this.$store.state.flashMessage.messages
    },
  },
  methods: {
    closeFlashMessage() {
      this.$store.commit('flashMessage/clearFlashMessage')
    }
  }
};
</script>
