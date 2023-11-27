import axios from '../../plugins/axios'

export default {
  namespaced: true,
  state: () => ({
    dataList: null,
    goalData: null,
    archivementRate: null,
  }),
  getters: {
    dataList: state => state.dataList,
    goalData: state => state.goalData,
    achievementRate: state => Math.round(state.achievementRate * 10) / 10, 
  },
  mutations: {
    setData(state, data) {
      state.dataList = data.graph_data
      state.goalData = data.goal
      state.achievementRate = data.achievement_rate
    }
  },
  actions: {
    async getGuestGraphData({ commit }, graphParams) {
      const graphResponse = await axios.post('guest_user_graph', graphParams)
        .catch((err) => {
          console.log(err)
          return null
        })
      commit('setData', graphResponse.data)
      return graphResponse.data
    },
    async getUserGraphData({ commit }) {
      try {
        const graphResponse = await axios.get('user_graph')
        commit('setData', graphResponse.data)
        return graphResponse.data.graph_data
      } catch (err) {
        console.error('Get users graph data failed', err)
        throw err
      }
    },
  }
}
