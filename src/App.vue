<template lang="pug">
  router-view
</template>

<script lang="coffee">
import { AppConfig, UserSession } from 'blockstack'
export default
  store: ['session', 'user']
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
