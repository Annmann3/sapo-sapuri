import { createRouter, createWebHistory } from 'vue-router'
import Home from '../pages/top/index'
import Login from '../pages/login/index'

const routes = [
  { path: '/', component: Home },
  { path: '/login', component: Login },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

export default router
