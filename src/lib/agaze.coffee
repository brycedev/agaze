
import { encryptECIES } from 'blockstack/lib/encryption'
import Ipfs from 'ipfs'
import Log from 'ipfs-log'

do
  c = mh: '', pk: ''
  i = null
  l = null
  sessionStorage.setItem('agaze:sid', uuid()) unless (sessionStorage.getItem('agaze:sid'))?
  sid = sessionStorage.getItem('agaze:sid')

  boot: () ->
    new Promise(resolve, reject) =>
      try
        i = new Ipfs(
          repo: 'agaze://.dev'
          start: false
          EXPERIMENTAL:  pubsub: true, sharding: false, dht: false
        )
        i.on 'error', (e) -> console.error(e)
        i.on 'ready', () ->
          l = Log.from(c.mh)
          resolve()
      catch: (err) ->
        console.log(err)
        reject()

  configure: (multihash, pubkey) ->
    c.mh = multihash
    c.pk = pubkey
    c

  uuid: () ->
    d = new Date().getTime()
    'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace /[xy]/g, (c) ->
      r = (d + Math.random() * 16) % 16 | 0
      d = Math.floor(d / 16)
      (if c is 'x' then r else r & 0x3 | 0x8).toString 16

  sendPageview: (data) ->
    req = window.location
    return if navigator.doNotTrack? is '1'
    return if document.visibilityState? is 'prerender'
    return if req.host is ''
    return if req.protocol isnt 'https'
    path = req.pathname + req.search
    path = '/' unless path?
    hostname = "#{req.protocol}//#{req.hostname}"
    ref = ''
    ref = document.referrer if document.referrer.indexOf(hostname) < 0
    data = id: uuid(), path: path, sid: sid, ref: ref
    encrData = encryptECIES c.pk, JSON.stringify data
    await l.append(encrData)

  window.agaze = () ->
    funcs = 'configure':configure, 'sendPageview':sendPageview
    args = [].slice.call arguments
    c = args.shift()
    funcs[c].apply @, args

  boot()
