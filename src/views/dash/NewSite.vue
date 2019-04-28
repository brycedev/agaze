<template lang="pug">
  div.max-w-sm.flex.flex-col.mx-auto.h-full.justify-center.pb-16
    h1.text-white.tracking-wide.text-4xl.text-center.mb-12 Create a new site
    input(class="subtle border-2 border-transparent rounded focus:border-agaze bg-slate appearance-none w-full px-4 py-3 text-center leading-tight focus:outline-none outline-none text-2xl font-light text-white mb-8" placeholder="Enter a site label" v-model="label")
    input(class="subtle border-2 border-transparent rounded focus:border-agaze bg-slate appearance-none w-full px-4 py-3 text-center leading-tight focus:outline-none outline-none text-2xl font-light text-white mb-8" placeholder="Enter a site url" @keydown.enter="submit()" v-model="url")
    button.rounded-lg.bg-agaze.text-white.cursor-pointer.px-4.py-3.text-2xl.opacity-50.subtle(@click="submit()" class="focus:outline-none" :class="{ 'opacity-100' : canSubmit }")
      p.font-light(v-if="!isSubmitting") Submit
      svg.w-6.fill-current.text-white.spin(xmlns='http://www.w3.org/2000/svg', viewBox='0 0 512 512' v-else)
        path(d='M304 48c0 26.51-21.49 48-48 48s-48-21.49-48-48 21.49-48 48-48 48 21.49 48 48zm-48 368c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.49-48-48-48zm208-208c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.49-48-48-48zM96 256c0-26.51-21.49-48-48-48S0 229.49 0 256s21.49 48 48 48 48-21.49 48-48zm12.922 99.078c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48c0-26.509-21.491-48-48-48zm294.156 0c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48c0-26.509-21.49-48-48-48zM108.922 60.922c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.491-48-48-48z')
</template>

<script lang="coffee">

export default
  store: ['session','models','indices','user']
  data: ->
    isSubmitting: false
    label: ''
    url: ''
  computed:
    canSubmit: -> @label isnt '' and @url isnt '' and @isUrl @url
  methods:
    isUrl: (url) ->
      pattern = new RegExp(
        "^" + "(?:(?:(?:https?):)?\\/\\/)" +
        "(?:\\S+(?::\\S*)?@)?" +
        "(?:" + "(?!(?:10|127)(?:\\.\\d{1,3}){3})" +
        "(?!(?:169\\.254|192\\.168)(?:\\.\\d{1,3}){2})" +
        "(?!172\\.(?:1[6-9]|2\\d|3[0-1])(?:\\.\\d{1,3}){2})" +
        "(?:[1-9]\\d?|1\\d\\d|2[01]\\d|22[0-3])" +
        "(?:\\.(?:1?\\d{1,2}|2[0-4]\\d|25[0-5])){2}" +
        "(?:\\.(?:[1-9]\\d?|1\\d\\d|2[0-4]\\d|25[0-4]))" +
        "|" + "(?:" + "(?:" + "[a-z0-9\\u00a1-\\uffff]" +
        "[a-z0-9\\u00a1-\\uffff_-]{0,62}" + ")?" +
        "[a-z0-9\\u00a1-\\uffff]\\." + ")+" +
        "(?:[a-z\\u00a1-\\uffff]{2,}\\.?)" + ")" +
        "(?::\\d{2,5})?" + "(?:[/?#]\\S*)?" + "$", "i"
      )
      pattern.test url
    submit: ->
      return if !@canSubmit
      url = new URL(@url)
      @isSubmitting = true
      newSite = label: @label, url: @url
      newSite.id = uuid('site')
      newSite.createdAt = Date.now()
      newSite.updatedAt = Date.now()
      dbName = "agaze.#{@user.pk.slice(0,8)}.#{url.host}"
      db = await orbit.create(dbName, 'docstore', { accessController: { write: ['*'], overwrite: true }})
      newSite.db = db.address.toString()
      @indices.sites.push newSite.id
      analytics = { events: [], pageviews: [] }
      await @session.putFile "sites.json", JSON.stringify @indices.sites, { encrypt : true }
      await @session.putFile "sites/#{newSite.id}.json", JSON.stringify newSite, { encrypt : true }
      await @session.putFile "sites/analytics/#{newSite.id}.json", JSON.stringify analytics, { encrypt : true }
      newSite.analytics = analytics
      @models.sites.push newSite
      @$router.push({ name: 'Main', params: { id: newSite.id } })
</script>