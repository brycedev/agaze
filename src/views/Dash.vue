<template lang="pug">
  .dash
    .flex.min-h-screen.w-full.men-slide.z-50.bg-black.absolute.pin-l(:class="{'l-300' : sideMenuOpen}")
      .container.flex.flex-col.flex-grow
        nav.py-4.w-full.flex.items-center.justify-between.mb-8
          div(class="w-1/3")
            svg(class="fill-current text-white w-8 h-8 cursor-pointer" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" @click="sideMenuOpen = !sideMenuOpen" v-if="$route.name == 'Main'")
              path(d="M80 280h256v48H80zM80 184h320v48H80zM80 88h352v48H80z")
                g
                  path(d="M80 376h288v48H80z")
            svg(class="fill-current text-white w-12 h-12 cursor-pointer" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" v-if="$route.name !== 'Main'" @click="$router.go(-1)")
              path(d="M216.4 163.7c5.1 5 5.1 13.3.1 18.4L155.8 243h231.3c7.1 0 12.9 5.8 12.9 13s-5.8 13-12.9 13H155.8l60.8 60.9c5 5.1 4.9 13.3-.1 18.4-5.1 5-13.2 5-18.3-.1l-82.4-83c-1.1-1.2-2-2.5-2.7-4.1-.7-1.6-1-3.3-1-5 0-3.4 1.3-6.6 3.7-9.1l82.4-83c4.9-5.2 13.1-5.3 18.2-.3z")
          div(class="w-1/3 flex items-center justify-center")
            h1.font-light.text-white.text-normal.tracking-wide.leading-none.pb-4 agāze
          div(class="w-1/3 bg-transparent flex items-center justify-end")
            p.text-white.uppercase.tracking-wide.text-sm.opacity-75.cursor-pointer(class="hover:opacity-100") https://forms.id
        .flex-grow
          router-view
    .fixed.pin-l.pin-b.pin-t.w-300.z-0.opacity-0.subtle(:class="{'opacity-100' : sideMenuOpen, 'pointer-events-none' : !sideMenuOpen}")
      .p-8.flex.items-center
        img.w-10.h-10.rounded-full.mr-4(:src="user.avatar")
        p.text-white.tracking-wide.text-xl(v-if="user") {{ user.username }}
      p.w-full.bg-slate.py-2.text-white.uppercase.px-8.mt-8 Sites
      .flex.justify-between.items-center.p-4.px-8.border-b.border-glass.text-white.tracking-wide.cursor-pointer.subtle(class="hover:bg-fog")
        p.text-xl Forms.id
        .w-4.h-4.bg-agaze.rounded-full.opacity-75
      .flex.justify-between.items-center.p-4.px-8.border-b.border-glass.text-white.tracking-wide.cursor-pointer.subtle(class="hover:bg-fog")
        p.text-xl Scrola.app
      .flex.justify-between.items-center.p-4.px-8.border-b.border-glass.text-white.tracking-wide.cursor-pointer.subtle(class="hover:bg-fog")
        p.text-xl Mantalabs.co
      router-link.no-underline.flex.justify-between.items-center.p-4.px-8.border-b.border-glass.text-white.tracking-wide.cursor-pointer.subtle(:to="{ name: 'NewSite'}" class="hover:bg-fog")
        p.text-xl.opacity-50 Add new site...

</template>

<script lang="coffee">
import MainChart from '../components/MainChart'

export default
  store: ['session', 'user']
  components: { MainChart }
  data: ->
    sideMenuOpen: false
  watch:
    $route: ->
      @sideMenuOpen = false
</script>

<style lang="stylus" scoped>
.l-300
  left 300px
.w-300
  width 300px
.men-slide
  transition left .1s linear
</style>
