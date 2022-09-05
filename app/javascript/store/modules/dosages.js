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
      // dosageがないときの処理
    },
    createDosage({ commit }, dosage) {
      axios.post('dosages', dosage)
        .then((res) => {
          commit('addDosage', res.data)
        })
        .catch((err) => {
          console.log(err)
        })
    },
    updateDosage({ commit }, dosage) {
      axios.patch(`dosages/${dosage.id}`, dosage)
        .then((res) => {
          commit('updateDosage', res.data)
        })
        .catch((err) => {
          console.log(err)
        })
    },
    deleteDosage({ commit }, dosage) {
      axios.delete(`dosages/${dosage.id}`)
        .then((res) => {
          commit('deleteDosage', res.data)
        })
        .catch((err) => {
          console.log(err)
        })
    },
  },
}
