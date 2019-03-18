<template lang="pug">
  div.max-w-sm.flex.flex-col.mx-auto.h-full.justify-center.pb-16
    h1.text-white.tracking-wide.text-4xl.text-center.mb-12 Create a new site
    input(class="subtle border-2 border-transparent rounded focus:border-agaze bg-slate appearance-none w-full px-4 py-3 text-center leading-tight focus:outline-none outline-none text-2xl font-light text-white mb-8" placeholder="Enter a site label" v-model="label")
    input(class="subtle border-2 border-transparent rounded focus:border-agaze bg-slate appearance-none w-full px-4 py-3 text-center leading-tight focus:outline-none outline-none text-2xl font-light text-white" placeholder="Enter a site url" @keydown.enter="submit()" v-model="url")
</template>

<script lang="coffee">
import Log from 'ipfs-log'

export default
  store: ['session','collections','indices','user']
  data: ->
    label: ''
    url: ''
  methods:
    submit: ->
      return if @label is '' or @url is ''
      log = new Log(new Ipfs())
      newSite = label: @label, url: @url
      newSite.id = uuid('site')
      newSite.li = log.id
      newSite.createdAt = Date.now()
      newSite.updatedAt = Date.now()
      @collections.sites.push(newSite)
      @indices.sites.push(newSite.id)
      # await @session.putFile "sites.json", JSON.stringify(@sites), { encrypt : true }
      # await @session.putFile "sites/#{newSite.id}.json", JSON.stringify(newSite), { encrypt : true }
      # await @session.putFile "sites/analytics/#{newSite.id}.json", JSON.stringify({ pageviews: [] }), { encrypt : true }
      @$router.push({ name: 'Main' })
</script>