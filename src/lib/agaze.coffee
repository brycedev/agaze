OrbitDB = require('orbit-db')
import { encryptECIES } from 'blockstack/lib/encryption'

do ->
  config = { pk: '' }
  ipfs = null
  log = null
  orbit = null
  sid = sessionStorage.getItem('agaze:sid')

  boot = () ->
    new Promise (resolve, reject) ->
      ipfs = new Ipfs
        repo: 'agaze://.dev'
        EXPERIMENTAL: pubsub: true
        config:
          Addresses:
            Swarm: ['/dns4/ws-star.discovery.libp2p.io/tcp/443/wss/p2p-websocket-star']
      ipfs.on 'error', (e) -> reject(e)
      ipfs.on 'ready', () ->
        orbit = new OrbitDB(ipfs)
        resolve()

  configure = (pubkey) ->
    config.pk = pubkey
    sessionStorage.setItem('agaze:sid', uuid()) unless sid?
    sid = sessionStorage.getItem('agaze:sid')
    try
      await boot()
    catch err
      console.log 'error booting ipfs :', err
    try
      dbName = "agaze.#{config.pk.slice(0,8)}.#{window.location.host}"
      log = await orbit.docstore(dbName, { write: ['*'], overwrite: false })
      console.log log
    catch err
      console.log 'error opening orbit db :', err
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
    return unless log? && config.pk !== ''
    req = window.location
    # return if navigator.doNotTrack is '1' <-- turn this on in prod
    return if document.visibilityState? is 'prerender'
    return if req.host is ''
    # return if req.protocol isnt 'https' <-- turn this on in prod
    path = req.pathname + req.search
    path = '/' unless path?
    hostname = "#{req.protocol}//#{req.hostname}"
    ref = false
    ref = document.referrer if document.referrer.indexOf(req.host) < 0
    # console.log 'referrer:', ref
    data = id: uuid(), path: path, sid: sid, ref: ref, ts:Date.now(), type: 'view'
    try
      encrData = await encryptECIES config.pk, JSON.stringify data
      hash = await log.put({ _id: uuid('orbit'), data: encrData })
    catch err
      console.log err
    return

  window.agaze = (args...) ->
    funcs = 'configure': configure, 'sendPageview': sendPageview
    c = args.shift()
    funcs[c].apply(this, args)
    return
  return
