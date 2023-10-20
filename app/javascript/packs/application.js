// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import '../stylehseets/application.css'

Rails.start()
ActiveStorage.start()


import { createApp } from 'vue'
import App from '../app.vue'
import store from '../store/index'
import router from '../router/index'
import VueGtag from 'vue-gtag'

const isProduction = process.env.NODE_ENV === 'production'
const trackingId = isProduction ? 'G-2FJ7449S2L' : 'G-Q58RMCNKDK'

document.addEventListener('DOMContentLoaded', () => {
  const app = createApp(App)
  app.use(store)
  app.use(router)
  app.mount('#app')
  app.use(VueGtag, {
    appName: 'SAPO-C',
    pageTrackerScreenviewEnabled: isProduction,
    config: { id: trackingId }
  }, router)
})
