import axios from '../../plugins/axios'

export default {
  namespaced: true,
  state: () => ({
    authUser: null
  }),
  getters: {
    authUser: state => state.authUser
  },
  mutations: {
    setAuthUser(state, user) {
      state.authUser = user
    },
    clearAuthUser(state) {
      state.authUser = null
    },
  },
  actions: {
    async login({ commit }, loginUser) {
      const userResponse = axios.post('/users', loginUser)
        .catch(err => console.log(err))
      if(!userResponse) return null
      userResponse
    }
  }
}
