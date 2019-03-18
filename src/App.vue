<template lang="pug">
  router-view.overflow-hidden
</template>

<script lang="coffee">
import { AppConfig, UserSession } from 'blockstack'

export default
  store: ['session', 'user']
  methods:
    setUser: ->
      userData = @session.loadUserData()
      console.log userData
      @user = {}
      @user.did = userData.decentralizedID
      @user.username = userData.profile?.name
      @user.username ||= userData.username
      @user.username ||= userData.identityAddress
      @user.avatar = userData.profile?.image?[0].contentUrl
      @user.avatar ||= 'https://picsum.photos/100'
  mounted: ->
    origin = window.location.origin
    confg = new AppConfig(['store_write'], origin, "/login")
    @session = new UserSession({ appConfig: confg })
    @setUser() if @session.isUserSignedIn()
</script>

<style lang="stylus">
@tailwind preflight
@tailwind components
@tailwind utilities
@font-face {
  font-family: greycliff;
  src: url(/fonts/greycliff-cf-regular.woff2);
}
body
  font-family greycliff
.subtle
  transition all .17s ease
</style>
