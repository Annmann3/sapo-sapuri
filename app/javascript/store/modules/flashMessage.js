export default {
  namespaced: true,
  state: {
    isFlashMessage: true,
    message: null,
    success: null,
    timeout: 5000,
  },
  mutations: {
    setFlashMessage(state, response) {
      state.isFlashMessage = true
      state.message = response.data.errors[0]
      state.success = response.data.success
      
      setTimeout(() => {
        state.isFlashMessage = false
        state.message = null
        state.success = null
      }, state.timeout)
    },
    clearFlashMessage(state) {
      state.isFlashMessage = false
      state.message = null
      state.success = null
    },
  },
}
