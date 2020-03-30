{ create-client } = require \redis

BOTNET = process.env.BOTNET or \eggr

export Bus = { send, receive }

pub = create-client 6379

function send type, signal, protocol, payload
  pub.publish "#{BOTNET}.#{type}.#{signal}.#{protocol}" (JSON.stringify payload)

function receive type, signal, protocol, subscriber
  sub = create-client 6379
  sub.on \message (channel, payload) ->
    msg = JSON.parse payload
    try subscriber msg
  sub.subscribe "#{BOTNET}.#{type}.#{signal}.#{protocol}"
