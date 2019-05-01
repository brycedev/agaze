import Vue from 'vue'
import Router from 'vue-router'
import Home from './views/Home.vue'
import Login from "./views/Login.vue";

Vue.use(Router)

export default new Router({
  mode: "history",
  base: process.env.BASE_URL,
  routes: [
    {
      path: "/",
      name: "Home",
      component: Home
    },
    {
      path: "/login",
      name: "Login",
      component: Login
    },
    {
      path: "/a",
      name: "Dash",
      component: () => import("./views/Dash.vue"),
      children: [
        {
          name: "NewSite",
          path: "new",
          component: () => import("./views/dash/NewSite.vue")
        },
        {
          name: "Main",
          path: ":id",
          component: () => import("./views/dash/Main.vue")
        }
      ]
    }
  ]
});
