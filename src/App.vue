<template lang="pug">
  router-view.overflow-hidden
</template>

<script lang="coffee">
import { AppConfig, UserSession } from 'blockstack'
import OrbitDB from 'orbit-db'

export default
  store: ['session', 'user']
  methods:
    connectIpfs: () ->
      new Promise (resolve, reject) ->
        repoPath = 'agaze://.dev'
        try
          ipfs = new Ipfs
            repo: repoPath
            EXPERIMENTAL: { pubsub: true, sharding: false, dht: false }
        catch err
          console.log(err)
          reject(err)
        ipfs.on('error', (e) => console.error(e))
        ipfs.on 'ready', () ->
          window.orbit = new OrbitDB(ipfs)
          resolve()
  mounted: ->
    await @connectIpfs()
    origin = window.location.origin
    confg = new AppConfig(['store_write'], origin, "/login")
    @session = new UserSession({ appConfig: confg })
</script>

<style lang="stylus">
@tailwind preflight
@tailwind components
@tailwind utilities
@font-face
  font-family greycliff
  src url(/fonts/greycliff-cf-regular.woff2)
body
  font-family greycliff
.subtle
  transition all .17s ease
@keyframes spin
    from
      transform:rotate(0deg)
    to
      transform:rotate(360deg)
.spin
  animation-name spin
  animation-duration 3000ms
  animation-iteration-count infinite
  animation-timing-function linear
</style>
