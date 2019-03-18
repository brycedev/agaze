<template lang="pug">
  .bg-black.min-h-screen.w-full.absolute
    .flex.min-h-screen.w-full.items-center.justify-center
      .rounded-lg.bg-agaze.text-white.p-6.cursor-pointer(@click="loginWithBlockstack()")
        p.font-light.text-lg Login
</template>

<script lang="coffee">
export default
  store: ['session', 'user']
  methods:
    loginWithBlockstack: -> @session.redirectToSignIn()
    setUser: ->
      userData = @session.loadUserData()
      @user = {}
      @user.did = userData.decentralizedID
      @user.username = userData.profile?.name
      @user.username ||= userData.username
      @user.username ||= userData.identityAddress
      @$router.push({ name: 'Main' })
  mounted: ->
    @$router.push({ name: 'Main' }) if @session.isUserSignedIn()
    @setUser() if !@session.isSignInPending()
    if @session.isSignInPending()
      await @session.handlePendingSignIn()
      @$router.push({ name: @$route.name })
      @setUser()
</script>