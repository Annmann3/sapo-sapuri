import { createApp } from 'vue'
import App from '../app.vue'
import '../../assets/stylesheets/application.tailwind.css'

document.addEventListener('DOMContentLoaded', () => {
  const app = createApp(App)
  app.mount('#app')
})

