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
      const data = response.data
      state.isFlashMessage = true
      state.success = data.success

      if(typeof data.errors === 'object'){
        state.message = data.data.errors.full_messages[0]
      } else {
        state.message = data.data.errors[0]
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
