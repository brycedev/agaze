<template lang="pug">
  .bg-black.flex.flex-col.min-h-screen.border-t-4.border-agaze
    .max-w-full.px-4
      .mx-auto.max-w-md.pt-4.pb-8
        .flex.items-center.justify-between
          h1.my-0.leading-loose.text-4xl.font-light.text-white agāze
          router-link.my-4.text-white.no-underline(:to="{ name: 'Login' }") Login
        p.text-2xl.my-6.leading-loose.text-white Simple, straightforward website analytics, with an emphasis on data privacy for you and your users.
    .px-4.flex-grow
      div.mx-auto.max-w-md.mb-8.text-white
        h3.my-1.text-xl.inline-block Data Privacy
        p.my-4.text-white.leading-loose.opacity-75 Our primary focus in building Agaze, was to ensure that user data is not collected and used by large corporations. All analytics data captured is encrypted and only available for viewing by the website owner. No data is ever stored on a central server controlled by Agaze.
      div.mx-auto.max-w-md.mb-8.text-white
        h3.my-1.text-xl.inline-block No Tracking
        p.my-4.text-white.leading-loose.opacity-75 The agaze software does not store any cookies or utilize any  pixels to follow your users around the web. In fact, no personally identifiable information is ever made available to the website owner.
      div.mx-auto.max-w-md.mb-8.text-white
        h3.my-1.text-xl.inline-block Minimal
        p.my-4.text-white.leading-loose.opacity-75 Just drop in the Javascript we provide, and we will handle the rest. Once the script is loaded, you can fire off pageviews and events at will.
      div.mx-auto.max-w-md.mb-8.text-white
        h3.my-1.text-xl.inline-block Free
        p.my-4.text-white.leading-loose.opacity-75 We don't charge users to utilize our software. If you'd like to create an account, it's free and all features are available. The software is also open source so you may improve it if needed.
    footer.mt-16.py-4.text-sm.px-4.text-white
      .mx-auto.container.flex.items-center.justify-between.max-w-md
        span.py-4 © Copyright 2019
        span.py-4 hi@agaze.co
</template>