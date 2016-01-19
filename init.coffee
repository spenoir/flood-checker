app = require './app'
config = require './config'

#if app.settings.env == 'production' or process.env.DEBUG_BUILD == 'local'
#  require './build'

console.log "Express server listening on port %d in %s mode",
  process.env.PORT || config.port, app.settings.env

app.listen process.env.PORT || config.port