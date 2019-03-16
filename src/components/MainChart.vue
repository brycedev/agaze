<template lang="pug">
  bar-chart.max-w-full(:chart-data="chartData" :options="options")
</template>

<script lang="coffee">
import BarChart from './BarChart'

export default
  components: { BarChart }
  data: ->
    chartData: {}
    options:
      responsive: true
      height: 300
      maintainAspectRatio: false
      legend: display: false
      scales:
        xAxes: [{ gridLines: { display: false }, ticks: { fontSize: 15, fontFamily: 'greycliff', padding: 10 } }]
        yAxes: [{ gridLines: { display: false }, ticks: { fontSize: 15, fontFamily: 'greycliff' } }]
      tooltips:
        enabled: false
        custom: (tooltipModel) =>
          body = tooltipModel.body
          customTooltip = body[0].lines[0].split(':')[1].trim() if body?
          customTooltip = null unless body?
          this.$emit('update:custom-tooltip', customTooltip)
  mounted: -> @fetchData()
  methods:
    fetchData: ->
      @chartData = {
        labels: ['/', 'about', 'faq', '404', 'testimonials'],
        datasets: [
          {
            label: 'Visits',
            backgroundColor: 'rgba(255,255,255,.54)',
            hoverBackgroundColor: 'rgba(255,255,255,.84)',
            data: [23, 19, 19, 12, 7],
          }
        ]
      }
    getRandomInt: -> Math.floor(Math.random() * (50 + 9)) + 120
</script>