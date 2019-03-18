import Vue from 'vue'
import App from './App.vue'
import router from './router'
import stash from 'vue-stash'
import './registerServiceWorker'

Vue.config.productionTip = false
Vue.use(stash)

new Vue({
  data: () => ({
    store: {
      session: null,
      user: null
    }
  }),
  router,
  render: h => h(App)
}).$mount('#app')
