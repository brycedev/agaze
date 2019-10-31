<template lang="pug">
  .dash
    .flex.min-h-screen.w-full.men-slide.z-50.bg-black.pin-l.fixed(:class="{'l-300' : sideMenuOpen}")
      .container.flex.flex-col.flex-grow(class="px-8")
        nav.py-4.w-full.flex.items-center.justify-between.mb-8
          div(class="w-1/3")
            svg(class="fill-current text-white w-8 h-8 cursor-pointer" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" @click="sideMenuOpen = !sideMenuOpen")
              path(d="M80 280h256v48H80zM80 184h320v48H80zM80 88h352v48H80z")
                g
                  path(d="M80 376h288v48H80z")
          div.cursor-pointer(class="w-1/3 flex items-center justify-center")
            h1.font-light.text-white.text-normal.tracking-wide.leading-none.pb-4 agāze
          div(class="w-1/3 bg-transparent flex items-center justify-end")
            p.cursor-pointer.text-white.uppercase.tracking-wide.text-sm.opacity-75(class="hover:opacity-100" v-if="$route.name !== 'NewSite' && activeSite" @click="showSiteModal = true") {{ activeSite.url }}
        .flex-grow
          router-view
    .fixed.pin-l.pin-b.pin-t.w-300.z-0.opacity-0.subtle.flex.flex-col(:class="{'opacity-100' : sideMenuOpen, 'pointer-events-none' : !sideMenuOpen}")
      .p-8.flex.items-center(v-if="user")
        img.w-10.h-10.rounded-full.mr-4(:src="user.avatar")
        p.text-white.tracking-wide.text-xl {{ user.username }}
      .w-full.flex-grow
        p.w-full.bg-slate.py-2.text-white.uppercase.px-8.mt-8 Sites
        router-link.no-underline.flex.justify-between.items-center.p-4.px-8.border-b.border-glass.text-white.tracking-wide.cursor-pointer.subtle(class="hover:bg-fog" v-for="site in models.sites" :to="{ name: 'Main', params: { id: site.id }}")
          p.text-xl {{ site.label }}
        router-link.no-underline.flex.justify-between.items-center.p-4.px-8.border-b.border-glass.text-white.tracking-wide.cursor-pointer.subtle(:to="{ name: 'NewSite'}" class="hover:bg-fog")
          p.text-xl.opacity-50 Add new site...
      .p-8.flex.items-center.justify-between
        ion-icon.text-white.cursor-pointer.opacity-75.subtle(class="hover:opacity-100" name="ios-cog" size="large" @click="showSiteModal = true")
        ion-icon.text-white.cursor-pointer.opacity-75.subtle(class="hover:opacity-100" name="log-out" size="large" @click="logout")
    div(class="subtle pin max-h-screen overflow-scroll h-screen fixed w-full bg-fog z-max flex items-center justify-center" @click.self="showSiteModal = false" :class="{'pointer-events-auto opacity-100' : showSiteModal, 'pointer-events-none opacity-0' : !showSiteModal}")
      .bg-white.rounded-lg.mb-4.shadow.max-w-md.w-full
        .flex.flex-col.p-6.text-agaze
          h3.font-light.mb-4 Site Configuration
          .flex.flex-col.w-full.py-4
            p.font-light.text-md.mb-4.text-grey-darker 1) Place script tags on your website.
            pre.overflow-scroll(class="resize-none subtle rounded-lg bg-grey-dark appearance-none w-full px-4 py-3 focus:outline-none outline-none text-base font-light text-white" readonly) {{ script }}
          .flex.flex-col.w-full.py-4
            p.font-light.text-md.mb-4.text-grey-darker 2) Configure your Agaze connection.
            pre.overflow-scroll(class="resize-none subtle rounded-lg bg-grey-dark appearance-none w-full px-4 py-3 focus:outline-none outline-none text-base font-light text-white" readonly) {{ configure }}
          .flex.flex-col.w-full.py-4
            p.font-light.text-md.mb-4.text-grey-darker 3) Send a pageview.
            .overflow-scroll(class="resize-none subtle rounded-lg bg-grey-dark appearance-none w-full px-4 py-3 focus:outline-none outline-none text-base font-light text-white" readonly) {{ sendView }}
          div.flex.justify-end.items-center
            //- div.bg-red-light.subtle.p-2.rounded.flex.items-center.cursor-pointer(class="hover:bg-red" @click="deleteActiveSite")
            //-   ion-icon.text-lg.mr-2.text-white(name="trash")
            //-   span.font-light.text-white Delete
</template>

<script lang="coffee">
import MainChart from '../components/MainChart'
isDev = process.env.NODE_ENV is 'development'
export default
  store: ['session','models','indices','user']
  components: { MainChart }
  data: ->
    sideMenuOpen: false
    showSiteModal: false
  computed:
    activeSite: -> (site for site in @models.sites when site.id is @$route.params.id)[0] || false
    script: -> '<script src=\"https:\/\/unpkg.com\/ipfs@0.34.4\/dist\/index.min.js\"><\/script>\n<script src=\"https:\/\/agaze.co\/js\/agaze.js\"><\/script>'
    configure: -> "await agaze('config', '#{@user.pk}')"
    sendView: -> "agaze('sendPageview')"
  methods:
    deleteActiveSite: ->

    logout: ->
      redirectTo = isDev ? 'localhost:8080' : 'https:://agaze.co'
      @session.signUserOut(redirectTo)
    openSiteModal: -> @showSiteModal = true
  mounted: ->
  watch:
    $route: -> @sideMenuOpen = false
</script>

<style lang="stylus" scoped>
.l-300
  left 300px
.w-300
  width 300px
.men-slide
  transition left .1s linear
</style>
