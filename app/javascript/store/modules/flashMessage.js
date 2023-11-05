export default {
  namespaced: true,
  state: {
    isFlashMessage: false,
    message: null,
    success: null,
    timeout: 5000,
  },
  mutations: {
    setFlashMessage(state, response) {
      state.isFlashMessage = true
      state.success = response.data.success
      if(typeof response.data.errors === 'object'){
        state.message = response.data.errors.full_messages[0]
      } else {
        state.message = response.data.errors[0]
      }
      
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
