<template lang="pug">
  .bg-black.min-h-screen.w-full.absolute
    .flex.min-h-screen.w-full.items-center.justify-center
      .rounded-lg.bg-agaze.text-white.p-6.cursor-pointer(@click="loginWithBlockstack()")
        p.font-light.text-lg Login
</template>

<script lang="coffee">
import { AppConfig, UserSession } from 'blockstack'
import { getPublicKeyFromPrivate } from 'blockstack/lib/keys'

export default
  store: ['indices', 'models', 'session', 'user']
  methods:
    loginWithBlockstack: -> @session.redirectToSignIn()
    setUser: ->
      await @session.putFile "sites.json", JSON.stringify [], { encrypt : true }
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
        @models.sites.push newSite
      if @indices.sites[0]?
        @$router.push({ name: 'Main', params: { id: @indices.sites[0] } })
      else
        @$router.push({ name: 'NewSite' })
  mounted: ->
    confg = new AppConfig(['store_write'], origin, "/login")
    @session = new UserSession({ appConfig: confg })
    @$router.push({ name: 'Dash' }) if @session.isUserSignedIn()
    @setUser() if !@session.isSignInPending()
    if @session.isSignInPending()
      await @session.handlePendingSignIn()
      @$router.push({ name: @$route.name })
      @setUser()
</script>