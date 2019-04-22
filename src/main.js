import Vue from 'vue'
import App from './App.vue'
import router from './router'
import stash from 'vue-stash'
import './registerServiceWorker'

Vue.config.productionTip = false
Vue.use(stash)
window.uuid = ((a, b) => {
  for (b = a = ''; a++ < 36; b += a * 51 & 52
  ? (a ^ 15 ? 8 ^ Math.random() * (a ^ 20 ? 16 : 4) : 4).toString(16) : '-');
  return b.replace(/-/g, "").slice(0, 8)
})
new Vue({
  data: () => ({
    store: {
      models: {
        sites: []
      },
      indices: {
        sites: []
      },
      session: null,
      user: null
    }
  }),
  router,
  render: h => h(App)
}).$mount("#app");
