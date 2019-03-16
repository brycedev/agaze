<template lang="pug">
  .bg-black.min-h-screen.w-full.men-slide.absolute.l-0(:class="{'l-300' : sideMenuOpen}")
    .container.flex.flex-col
      nav.py-4.w-full.flex.items-center.justify-between.mb-8
        div(class="w-1/3")
          svg(class="fill-current text-white w-8 h-8 cursor-pointer" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" @click="sideMenuOpen = !sideMenuOpen")
            path(d="M80 280h256v48H80zM80 184h320v48H80zM80 88h352v48H80z")
              g
                path(d="M80 376h288v48H80z")
          svg(class="fill-current text-white w-12 h-12 cursor-pointer" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" v-if="true == false")
            path(d="M216.4 163.7c5.1 5 5.1 13.3.1 18.4L155.8 243h231.3c7.1 0 12.9 5.8 12.9 13s-5.8 13-12.9 13H155.8l60.8 60.9c5 5.1 4.9 13.3-.1 18.4-5.1 5-13.2 5-18.3-.1l-82.4-83c-1.1-1.2-2-2.5-2.7-4.1-.7-1.6-1-3.3-1-5 0-3.4 1.3-6.6 3.7-9.1l82.4-83c4.9-5.2 13.1-5.3 18.2-.3z")
        div(class="w-1/3 flex items-center justify-center")
          h1.font-light.text-white.text-normal.tracking-wide.leading-none.pb-4 agāze
        div(class="w-1/3 bg-transparent flex items-center justify-end")
          p.text-white.uppercase.tracking-wide.text-sm.opacity-75.cursor-pointer(class="hover:opacity-100") https://forms.id
      .w-full.flex.flex-col.mb-12
        .flex.items-center.mx-4.pb-6
          p.text-white.uppercase.tracking-wide.text-sm.opacity-75.cursor-pointer.mr-4(class="hover:opacity-100" :class="{'opacity-100' : timePeriod == 'today' }" @click="timePeriod = 'today'") Today
          p.text-white.uppercase.tracking-wide.text-sm.opacity-75.cursor-pointer.mr-4(class="hover:opacity-100" :class="{'opacity-100' : timePeriod == 'week' }" @click="timePeriod = 'week'") Week
          p.text-white.uppercase.tracking-wide.text-sm.opacity-75.cursor-pointer.mr-4(class="hover:opacity-100" :class="{'opacity-100' : timePeriod == 'month' }" @click="timePeriod = 'month'") Month
          p.text-white.uppercase.tracking-wide.text-sm.opacity-75.cursor-pointer.mr-4(class="hover:opacity-100" :class="{'opacity-100' : timePeriod == 'year' }" @click="timePeriod = 'year'") Year
        .flex
          div(class="w-full md:w-1/3")
            .mx-4.rounded-lg.bg-agaze.flex.flex-col.p-6
              p.text-white.uppercase.tracking-wide.mb-4.text-sm Site Visits
              h1.text-white.m-0.tracking-wide.text-6xl.font-normal 92
          div(class="w-full md:w-1/3")
            .mx-4.rounded-lg.bg-agaze.flex.flex-col.p-6
              p.text-white.uppercase.tracking-wide.mb-4.text-sm Page Views
              h1.text-white.m-0.tracking-wide.text-6xl.font-normal(v-if="customPageViews") {{ customPageViews }}
              h1.text-white.m-0.tracking-wide.text-6xl.font-normal(v-else) {{ pageViews }}
          div(class="w-full md:w-1/3")
            .mx-4.rounded-lg.bg-agaze.flex.flex-col.p-6
              p.text-white.uppercase.tracking-wide.mb-4.text-sm Avg. Time On Site
              h1.text-white.m-0.tracking-wide.text-6xl.font-normal 1:32
      .flex.justify-end.mx-4
        .flex.items-center.pb-6
          svg(class="fill-current text-white w-6 h-6 cursor-pointer mr-3 hover:opacity-100 opacity-75" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" :class="{'opacity-100' : !listView }" @click="listView = false")
            path(d="M184 448h48c4.4 0 8-3.6 8-8V72c0-4.4-3.6-8-8-8h-48c-4.4 0-8 3.6-8 8v368c0 4.4 3.6 8 8 8zM88 448h48c4.4 0 8-3.6 8-8V296c0-4.4-3.6-8-8-8H88c-4.4 0-8 3.6-8 8v144c0 4.4 3.6 8 8 8zM280.1 448h47.8c4.5 0 8.1-3.6 8.1-8.1V232.1c0-4.5-3.6-8.1-8.1-8.1h-47.8c-4.5 0-8.1 3.6-8.1 8.1v207.8c0 4.5 3.6 8.1 8.1 8.1zM368 136.1v303.8c0 4.5 3.6 8.1 8.1 8.1h47.8c4.5 0 8.1-3.6 8.1-8.1V136.1c0-4.5-3.6-8.1-8.1-8.1h-47.8c-4.5 0-8.1 3.6-8.1 8.1z")
          svg(class="fill-current text-white w-6 h-6 cursor-pointer hover:opacity-100 opacity-75" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" :class="{'opacity-100' : listView }" @click="listView = true")
            path(d="M426.2 80.4l-170.2 32-170.2-32C64 77 48 97.3 48 118v244.5c0 20.7 16 32.6 37.8 37.6L256 432l170.2-32c21.8-5 37.8-16.9 37.8-37.6V118c0-20.7-16-41-37.8-37.6zm0 282l-151.2 32V149.9l151.2-32v244.5zm-189.2 32l-151.2-32V118L237 150v244.4z")
      main-chart(:custom-tooltip.sync="customPageViews" v-on:update:custom-tooltip="customPageViews = $event" v-if="!listView")
      .flex.mx-4(v-else)
        .mr-2(class="w-1/2")
          p.w-full.bg-slate.py-2.text-white.uppercase.px-4.rounded Pages
          .flex.justify-between.items-center.p-4.border-b.border-glass.text-white.tracking-wide.cursor-pointer.rounded.subtle(class="hover:bg-fog")
            p /
            p 217
        .ml-2(class="w-1/2")
          p.w-full.bg-slate.py-2.text-white.uppercase.px-4.rounded Referrers
          .flex.justify-between.items-center.p-4.border-b.border-glass.text-white.tracking-wide.cursor-pointer.rounded.subtle(class="hover:bg-fog")
            p producthunt.com
            p 15
          .flex.justify-between.items-center.p-4.border-b.border-glass.text-white.tracking-wide.cursor-pointer.rounded.subtle(class="hover:bg-fog")
            p apple.com
            p 7
          .flex.justify-between.items-center.p-4.border-b.border-glass.text-white.tracking-wide.cursor-pointer.rounded.subtle(class="hover:bg-fog")
            p socialmediaexaminer.com
            p 4
          .flex.justify-between.items-center.p-4.border-b.border-glass.text-white.tracking-wide.cursor-pointer.rounded.subtle(class="hover:bg-fog")
            p fanburst.com
            p 1
</template>

<script lang="coffee">
import MainChart from '../components/MainChart'
import { Model, Zapp } from '../../../zapp/pkg/dist-web/index.js'

export default
  components: { MainChart }
  data: ->
    customPageViews: null,
    pageViews: 119,
    sideMenuOpen: false,
    listView: false,
    timePeriod: 'today'
</script>

<style lang="stylus" scoped>
.l-0
  left 0px
.l-300
  left 300px
.men-slide
  transition left .1s linear
</style>
