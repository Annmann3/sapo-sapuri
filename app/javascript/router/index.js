import { createRouter, createWebHistory } from 'vue-router'
import store from '../store/index'
import Home from '../pages/top/index'
import Login from '../pages/login/index'
import Register from '../pages/register/index'
import Password from '../pages/password/index'
import PasswordEdit from '../pages/password/edit/index'
import Graph from '../pages/graph/index'
import GuestGraph from '../pages/guest-graph/index'
import Dosages from '../pages/dosages/index'
import LineCallback from '../pages/oauth/line/Callback'
import PrivacyPolicy from '../pages/privacy-policy/index'
import TermsOfService from '../pages/terms/index'
import Notes from '../pages/notes/index'
import LineIntegration from '../pages/line-integration/index'
import MyPage from '../pages/my-page/index'


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
    path: '/guest-graph',
    component: GuestGraph,
    meta: { requiredAuth: false }
  },
  {
    path: '/oauth/line/callback',
    component: LineCallback,
    meta: { requiredAuth: false }
  },
  {
    path: '/privacy-policy',
    component: PrivacyPolicy,
    meta: { requiredAuth: false }
  },
  {
    path: '/terms',
    component: TermsOfService,
    meta: { requiredAuth: false }
  },
  {
    path: '/notes',
    component: Notes,
    meta: { requiredAuth: false }
  },
  {
    path: '/line-integration',
    component: LineIntegration,
    meta: { requiredAuth: false }
  },
  {
    path: '/my-page',
    component: MyPage,
    meta: { requiredAuth: true }
  }
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
      }else{
        next()
      }
    })
})

export default router
