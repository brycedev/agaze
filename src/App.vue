<template lang="pug">
  router-view
</template>

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
