<template lang="pug">
  .bg-black.min-h-screen.w-full.absolute
    .flex.min-h-screen.w-full.items-center.justify-center
      .rounded-lg.bg-agaze.text-white.p-6.cursor-pointer(@click="loginWithBlockstack()")
        p.font-light.text-lg Login
</template>

<script lang="coffee">
import { AppConfig, UserSession } from 'blockstack'
import { decryptECIES } from 'blockstack/lib/encryption'
import { getPublicKeyFromPrivate } from 'blockstack/lib/keys'
import OrbitDB from 'orbit-db'
isDev = process.env.NODE_ENV is 'development'

export default
  store: ['indices', 'models', 'session', 'user']
  methods:
    loginWithBlockstack: -> @session.redirectToSignIn()
    connectIpfs: () ->
      new Promise (resolve, reject) ->
        repoPath = 'agaze://.dev'
        try
          ipfs = new Ipfs
            repo: repoPath
            EXPERIMENTAL: pubsub: true
          ipfs.on('error', (e) => console.error(e))
          ipfs.on 'ready', () ->
            window.orbit = new OrbitDB(ipfs)
            resolve()
        catch err
          console.error(err)
          reject(err)
    setUser: ->
      # await @session.putFile "sites.json", JSON.stringify [], { encrypt : true }
      pubKey = null
      userData = @session.loadUserData()
      try
        pubkey = JSON.parse await @session.getFile 'key.txt', { decrypt : true }
      catch err
        pubKey = getPublicKeyFromPrivate(userData.appPrivateKey)
        await @session.putFile 'key.txt', pubKey, { encrypt : true }
      @user.apk = userData.appPrivateKey
      @user.did = userData.decentralizedID
      @user.pk = pubKey
      @user.username = userData.profile?.name || userData.username || userData.identityAddress
      @user.avatar = userData.profile?.image?[0]?.contentUrl || 'https://picsum.photos/100'
      @indices.sites = JSON.parse await @session.getFile "sites.json", { decrypt : true } || []
      for key, site of @indices.sites
        newSite = JSON.parse(await @session.getFile "sites/#{site}.json", { decrypt : true })
        newSite.analytics = JSON.parse(await @session.getFile "sites/analytics/#{site}.json", { decrypt : true })
        db = await orbit.docstore(newSite.db)
        await db.load()
        analytics = db.query (doc) -> doc
        for lytic in analytics
          uniqOrbitId = lytic._id
          decryptedLytic = JSON.parse(decryptECIES(@user.apk, lytic.data))
          decryptedLytic._id = uniqOrbitId
          isLogged = (newSite.analytics.map (l) -> l._id).includes(uniqOrbitId)
          newSite.analytics.push(decryptedLytic) if !isLogged
        await @session.putFile "sites/analytics/#{site}.json", JSON.stringify newSite.analytics, { encrypt : true }
        @models.sites.push newSite

  mounted: ->
    await @connectIpfs()
    scopes = ['store_write']
    scopes = ['store_write', 'publish_data'] if !isDev
    confg = new AppConfig(scopes, origin, "/login")
    @session = new UserSession({ appConfig: confg })
    if @session.isSignInPending()
      await @session.handlePendingSignIn()
      @$router.push({ name: @$route.name })
      @setUser()
      return
    @session.redirectToSignIn() unless @session.isUserSignedIn()
    if @session.isUserSignedIn()
      await @setUser()
      if @indices.sites[0]?
        @$router.push({ name: 'Main', params: { id: @indices.sites[0] } })
      else
        @$router.push({ name: 'NewSite' })
</script>