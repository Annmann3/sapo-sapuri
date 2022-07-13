import { createRouter, createWebHistory } from 'vue-router'
import Home from '../pages/top/index'
import Login from '../pages/login/index'
import Register from '../pages/register/index'

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
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

export default router
