<template lang="pug">
  .bg-black.min-h-screen.w-full.absolute
    .flex.min-h-screen.w-full.items-center.justify-center
      .rounded-lg.bg-agaze.text-white.p-6.cursor-pointer(@click="loginWithBlockstack()")
        p.font-light.text-lg Login
</template>

<script lang="coffee">
import { AppConfig, UserSession } from 'blockstack'

export default
  store: ['user']
  data: ->
    origin = window.location.origin
    confg = new AppConfig(['store_write'], origin, "/login")
    session: new UserSession({ appConfig: confg })
  methods:
    loginWithBlockstack: -> @session.redirectToSignIn()
    setUser: ->
      userData = @session.loadUserData()
      @user = {}
      @user.did = userData.decentralizedID
      @user.username = userData.profile?.name
      @user.username ||= userData.username
      @user.username ||= userData.identityAddress
      @$router.push({ name: 'Dash' })
  mounted: ->
    @setUser() if !@session.isSignInPending()
    if @session.isSignInPending()
      await @session.handlePendingSignIn()
      @$router.push({ name: @$route.name })
      @setUser()
</script>

<style scoped>

</style>