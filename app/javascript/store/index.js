import { createStore } from 'vuex'
import users from './modules/users'
import graph from './modules/graph'

const store = createStore({
  modules: {
    users,
    graph,
  }
})

export default store
