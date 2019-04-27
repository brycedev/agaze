require('crypto')
eccrypto = require("eccrypto")
import Log from 'ipfs-log'

do ->
  config = { li: '', pk: '' }
  funcs = 'configure': configure, 'sendPageview': sendPageview
  ipfs = null
  log = null
  sid = sessionStorage.getItem('agaze:sid')

  boot = () ->
    new Promise (resolve, reject) ->
      ipfs = new Ipfs(
        repo: 'agaze://.dev'
        start: false
        EXPERIMENTAL:  pubsub: true
      )
      ipfs.on 'error', (e) -> reject(e)
      ipfs.on 'ready', () -> resolve()

  configure = (logid, pubkey) ->
    console.log 'configuring'
    config.li = logid
    config.pk = pubkey
    sessionStorage.setItem('agaze:sid', uuid()) unless sid?
    sid = sessionStorage.getItem('agaze:sid')
    # await boot()
    log = new Log(ipfs, null, { logId: config.li })
    return

  uuid = () ->
    d = new Date().getTime()
    l = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace /[xy]/g, (c) ->
      r = (d + Math.random() * 16) % 16 | 0
      d = Math.floor(d / 16)
      (if c is 'x' then r else r & 0x3 | 0x8).toString 16
    l.replace(/-/g, "")

  sendPageview = (data) ->
    console.log 'attempting to send pageview'
    return unless log?
    req = window.location
    console.log 'req:', req
    console.log 'should we track? : ', navigator.doNotTrack isnt '1'
    console.log 'retreating' if navigator.doNotTrack is '1'
    # return if navigator.doNotTrack is '1' <-- turn this on in prod
    return if document.visibilityState? is 'prerender'
    return if req.host is ''
    # return if req.protocol isnt 'https' <-- turn this on in prod
    path = req.pathname + req.search
    path = '/' unless path?
    hostname = "#{req.protocol}//#{req.hostname}"
    ref = ''
    ref = document.referrer if document.referrer.indexOf(hostname) < 0
    console.log 'referrer:', ref
    data = id: uuid(), path: path, sid: sid, ref: ref
    # encrData = await eccrypto.encrypt config.pk, JSON.stringify data
    console.log 'sending data: ', data
    console.log 'sending encrypted data: ', encrData
    # await log.append(encrData || {})
    return

  window.agaze = () ->
    console.log 'agazing'
    args = [].slice.call(arguments)
    c = args.shift()
    funcs[c].apply(this, args)
    return
  return
