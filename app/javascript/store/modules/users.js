import {locale} from 'dayjs'
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
  },
  actions: {
    async signin({ commit }, loginUser) {
      try {
        const userResponse = await axios.post('auth/sign_in', loginUser)
        localStorage.setItem('client', userResponse.headers['client'])
        localStorage.setItem('uid', userResponse.headers['uid'])
        localStorage.setItem('access-token', userResponse.headers['access-token'])

        axios.defaults.headers.common['client'] = userResponse.headers['client']
        axios.defaults.headers.common['uid'] = userResponse.headers['uid']
        axios.defaults.headers.common['access-token'] = userResponse.headers['access-token']
        commit('setAuthUser', userResponse.data)
      } catch (err) {
        console.error('Sign-in failed', err)
        throw err
      }
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
    async createUser({ dispatch }, user) {
      try {
        const userResponse = await axios.post('auth/', user)
        const loginUser = {
          email: user.email,
          password: user.password
        }
        await dispatch('signin', loginUser)
      } catch (err) {
        console.error('Create user failed', err)
        throw err
      }
    },
    async updateUser({ commit }, user) {
      try {
        const userResponse = await axios.patch('auth/', user)
        debugger
        commit('setAuthUser', userResponse.data.data)
        localStorage.setItem('client', userResponse.headers['client'])
        localStorage.setItem('uid', userResponse.headers['uid'])
        localStorage.setItem('access-token', userResponse.headers['access-token'])

        axios.defaults.headers.common['client'] = userResponse.headers['client']
        axios.defaults.headers.common['uid'] = userResponse.headers['uid']
        axios.defaults.headers.common['access-token'] = userResponse.headers['access-token']
      } catch (err) {
        console.error('Update user failed', err)
        throw err
      }
    },
    async deleteUser({ commit }, user) {
      try {
        const userResponse = await axios.delete('auth/', user)
        commit('setAuthUser', null)
        localStorage.removeItem('client')
        localStorage.removeItem('uid')
        localStorage.removeItem('access-token')

        axios.defaults.headers.common['client'] = ''
        axios.defaults.headers.common['uid'] = ''
        axios.defaults.headers.common['access-token'] = ''
      } catch (err) {
        console.error('Delete user failed', err)
        throw err
      }
    },
    //ユーザー情報の取得 or null
    async fetchAuthUser({ commit, state }) {
      if(!localStorage.getItem('access-token')) return null
      if(state.authUser) return state.authUser
      //axios defaults headerからユーザー認証を行う
      try {
        const userResponse = await axios.get('auth/validate_token')
        commit('setAuthUser', userResponse.data.data)
        return userResponse.data.data
      } catch (err) {
        console.log(err)
        return null
      }
    },
    //oauth用
    async oauthSignin({ commit }, header) {
      try {
        const userResponse = await axios.get('auth/validate_token',{
          headers: header
        })
        commit('setAuthUser', userResponse.data.data)
        localStorage.setItem('client', userResponse.headers['client'])
        localStorage.setItem('uid', userResponse.headers['uid'])
        localStorage.setItem('access-token', userResponse.headers['access-token'])
        axios.defaults.headers.common['client'] = userResponse.headers['client']
        axios.defaults.headers.common['uid'] = userResponse.headers['uid']
        axios.defaults.headers.common['access-token'] = userResponse.headers['access-token']
        return userResponse.data.data
      } catch (err) {
        console.error('Oauth sign in failed', err)
        throw err
      }
    },
    async signinWithLineIdToken({ commit }, lineIdToken) {
      try {
        const userResponse = await axios.post('liff_sign_in', {id_token: lineIdToken})
        localStorage.setItem('client', userResponse.headers['client'])
        localStorage.setItem('uid', userResponse.headers['uid'])
        localStorage.setItem('access-token', userResponse.headers['access-token'])
        axios.defaults.headers.common['client'] = userResponse.headers['client']
        axios.defaults.headers.common['uid'] = userResponse.headers['uid']
        axios.defaults.headers.common['access-token'] = userResponse.headers['access-token']
        commit('setAuthUser', userResponse.data.data)
      } catch (err) {
        console.error('signinWithLineIdToken failed', err)
        throw err
      }
    },
    resetPasswordMail({ commit }, user) {
      const resetPasswordParams = {
        email: user.email,
        redirect_url: 'http://localhost:3000/password/edit'
      }
      axios.post('auth/password', resetPasswordParams)
    },
    async updatePassword({ commit }, {user, headers}) {
      const userResponse = await axios.put('auth/password',
        {
          password: user.password,
          password_confirmation: user.password_confirmation,
        },
        {
          headers: headers
        }
      )
      // ログイン状態にする
      localStorage.setItem('client', userResponse.headers['client'])
      localStorage.setItem('uid', userResponse.headers['uid'])
      localStorage.setItem('access-token', userResponse.headers['access-token'])

      axios.defaults.headers.common['client'] = userResponse.headers['client']
      axios.defaults.headers.common['uid'] = userResponse.headers['uid']
      axios.defaults.headers.common['access-token'] = userResponse.headers['access-token']

      commit('setAuthUser', userResponse.data.data)
    }
  }
}
