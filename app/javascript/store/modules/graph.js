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
    async getNutrinetData({ commit }, nutrientId) {
      const graphResponse = await axios.get(`graph/nutrient/${nutrientId}`)
        .catch((err) => {
          console.log(err)
          return null
        })
      commit('setDataList', graphResponse.data)
      return graphResponse.data
    },
    async getNutrinetDataByDosageAt({ commit }) {
      const graphResponse = await axios.get('graph/me')
      .catch((err) => {
        console.log(err)
        return null
      })
      commit('setDataList', graphResponse.data)
      return graphResponse.data
    },
  }
}
