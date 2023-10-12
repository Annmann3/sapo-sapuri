import { createStore } from 'vuex'
import users from './modules/users'
import graph from './modules/graph'
import dosages from './modules/dosages'
import flashMessage from './modules/flashMessage'

const store = createStore({
  modules: {
    users,
    graph,
    dosages,
    flashMessage,
  }
})

export default store
