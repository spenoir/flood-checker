app = require './app'
config = require './config'

console.log "Express server listening on port %d in %s mode",
  process.env.PORT || config.port, app.settings.env

app.listen process.env.PORT || config.port