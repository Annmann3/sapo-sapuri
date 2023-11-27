export default {
  namespaced: true,
  state: {
    isFlashMessage: false,
    messages: [],
    success: null,
    timeout: 5000,
  },
  mutations: {
    setFlashMessage(state, response) {
      const data = response.data
      state.isFlashMessage = true
      state.success = data.success
      state.messages = data.errors
      
      setTimeout(() => {
        state.isFlashMessage = false
        state.messages = []
        state.success = null
      }, state.timeout)
    },
    clearFlashMessage(state) {
      state.isFlashMessage = false
      state.messages = []
      state.success = null
    },
  },
}
