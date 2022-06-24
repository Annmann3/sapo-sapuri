import { createApp } from 'vue'
import App from '../app.vue'
import store from '../store/index'
import router from '../router/index'
import '../../assets/stylesheets/application.tailwind.css'

document.addEventListener('DOMContentLoaded', () => {
  const app = createApp(App)
  app.use(store)
  app.use(router)
  app.mount('#app')
})

