import { createApp } from 'vue'
import App from '../app.vue'
import store from '../store/index'
import '../../assets/stylesheets/application.tailwind.css'

document.addEventListener('DOMContentLoaded', () => {
  const app = createApp(App)
  app.use(store)
  app.mount('#app')
})

