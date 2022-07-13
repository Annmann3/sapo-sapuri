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
    async signin({ commit }, loginUser) {
      const userResponse = await axios.post('auth/sign_in', loginUser)
        .catch(err => console.log(err))
      localStorage.setItem('client', userResponse.headers['client'])
      localStorage.setItem('uid', userResponse.headers['uid'])
      localStorage.setItem('access-token', userResponse.headers['access-token'])

      axios.defaults.headers.common['client'] = userResponse.headers['client']
      axios.defaults.headers.common['uid'] = userResponse.headers['uid']
      axios.defaults.headers.common['access-token'] = userResponse.headers['access-token']
      commit('setAuthUser', userResponse.data)
    },
    async signout({ commit }) {
      await axios.delete('auth/sign_out')
        .catch(err => console.log(err))
      localStorage.removeItem('client')
      localStorage.removeItem('uid')
      localStorage.removeItem('access-token')
      axios.defaults.headers.common['client'] = ''
      axios.defaults.headers.common['uid'] = ''
      axios.defaults.headers.common['access-token'] = ''
      commit('setAuthUser', null)
    },
    createUser({ dispatch }, user) {
      axios.post('auth/', user)
        .then((res) => {
          const loginUser = {
            email: user.email,
            password: user.password
          }
          dispatch('signin', loginUser)
        })
        .catch(err => console.log(err))
    },
    //ユーザー情報の取得 or null
    async fetchAuthUser({ commit, state }) {
      if(!localStorage.getItem('access-token')) return null
      if(state.authUser) return state.authUser
      //ヘッダーのuid access-token clientで取得
      const userResponse = await axios.get('auth/validate_token')
        .catch((err) => {
          console.log(err)
          return null
        })

      commit('setAuthUser', userResponse.data.data)
      return userResponse.data.data
    }
  }
}
