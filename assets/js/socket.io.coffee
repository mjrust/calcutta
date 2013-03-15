module.exports = (app, server) ->
  io = require('socket.io').listen(server)
  unless app.settings.io
    app.set 'io', io
  io.sockets.on 'connection', (socket) ->
    console.log "CONNECTED"