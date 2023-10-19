import axios from '../../plugins/axios'

export default {
  namespaced: true,
  state: () => ({
    dataList: null
  }),
  getters: {
    dataList: state => state.dataList
  },
  mutations: {
    setDataList(state, data) {
      state.dataList = data
    }
  },
  actions: {
    async getGuestGraphData({ commit }, graphParams) {
      const graphResponse = await axios.post('guest_user_graph', graphParams)
        .catch((err) => {
          console.log(err)
          return null
        })
      commit('setDataList', graphResponse.data)
      return graphResponse.data
    },
    async getUserGraphData({ commit }, graphParams) {
      try {
        const graphResponse = await axios.post('user_graph', graphParams)
        commit('setDataList', graphResponse.data)
        return graphResponse.data
      } catch (err) {
        console.error('Get users graph data failed', err)
        throw err
      }
    },
  }
}
