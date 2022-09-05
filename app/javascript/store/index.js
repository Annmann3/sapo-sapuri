import { createStore } from 'vuex'
import users from './modules/users'
import graph from './modules/graph'
import dosages from './modules/dosages'

const store = createStore({
  modules: {
    users,
    graph,
    dosages,
  }
})

export default store
