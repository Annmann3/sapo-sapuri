import axios from '../../plugins/axios'

export default {
  namespaced: true,
  state: () => ({
    dosageList: []
  }),
  getters: {
    dosageList: state => state.dosageList,
  },
  mutations: {
    setDosageList(state, dosages) {
      state.dosageList = dosages
    },
    addDosage(state, dosage) {
      state.dosageList.push(dosage)
    },
    updateDosage(state, dosage) {
      const index = state.dosageList.findIndex(el => el.id === dosage.id)
      if (index !== -1) {
        state.dosageList.splice(index, 1, dosage)
      }
    },
    deleteDosage(state, dosage) {
      const index = state.dosageList.findIndex(el => el.id === dosage.id)
      if (index !== -1) {
        state.dosageList.splice(index, 1)
      }
    },
  },
  actions: {
    fetchDosages({ commit }) {
      axios.get('dosages')
        .then((res) => {
          commit('setDosageList', res.data)
        })
        .catch((err) => {
          console.log(err)
        })
    },
    async createDosage({ commit }, dosage) {
      try{
        const dosageResponse = await axios.post('dosages', dosage)
        commit('addDosage', dosageResponse.data.data)
      } catch (err) {
        console.error(err)
        throw err
      }
    },
    async updateDosage({ commit }, dosage) {
      try {
        const dosageResponse = await axios.patch(`dosages/${dosage.id}`, dosage)
        commit('updateDosage', dosageResponse.data.data)
      } catch (err) {
        console.error(err)
        throw err
      }
    },
    deleteDosage({ commit }, dosage) {
      axios.delete(`dosages/${dosage.id}`)
        .then((res) => {
          commit('deleteDosage', res.data.data)
        })
        .catch((err) => {
          console.log(err)
        })
    },
  },
}
