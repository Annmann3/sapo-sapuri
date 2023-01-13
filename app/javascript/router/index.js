import { createRouter, createWebHistory } from 'vue-router'
import store from '../store/index'
import Home from '../pages/top/index'
import Login from '../pages/login/index'
import Register from '../pages/register/index'
import Password from '../pages/password/index'
import PasswordEdit from '../pages/password/edit/index'
import Graph from '../pages/graph/MyGraph'
import Dosages from '../pages/dosages/index'
import test from '../pages/graph/index'

const routes = [
  {
    path: '/',
    component: Home,
    meta: { requiredAuth: false }
  },
  {
    path: '/login',
    component: Login,
    meta: { requiredAuth: false }
  },
  {
    path: '/register', 
    component: Register,
    meta: { requiredAuth: false }
  },
  {
    path: '/password', 
    component: Password,
    meta: { requiredAuth: false }
  },
  {
    path: '/password/edit', 
    component: PasswordEdit,
    meta: { requiredAuth: false }
  },
  {
    path: '/graph', 
    component: Graph,
    meta: { requiredAuth: true }
  },
  {
    path: '/dosages',
    component: Dosages,
    meta: { requiredAuth: true }
  },
  {
    path: '/test',
    component: test,
    meta: { requiredAuth: false }
  },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

// ログインが必要なページの制御
router.beforeEach( (to, from, next) => {
  store.dispatch('users/fetchAuthUser')
    .then((authUser) => {
      if(to.meta.requiredAuth && !authUser){
        next({ path: '/login' })
      }else if(to.path === '/' && authUser){ 
        // ログイン済みの場合はトップページに遷移させない
        next({ path: '/graph' })
      }else{
        next()
      }
    })
})

export default router
