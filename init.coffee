CronJob = require('cron').CronJob
app = require './app'
apiWrapper = require './GetFloodData'
config = require './config'

job = new CronJob(
  cronTime: '46 19 * * *'
  onTick: () ->
    # Runs every day
    api = new apiWrapper()
    api.makeRequest().then( (response) ->
      api.findNew(response.items).then((newWarnings) ->
        api.newBatch(newWarnings).then((addedWarnings) ->
          console.log("Added #{addedWarnings.length} new warnings")
          Warning.find({}, (err, warnings) ->
            console.log("Total warnings: #{warnings.length}")
          )

        )
      )
    )
  ,
  start: false,
  timeZone: 'Europe/London'
)
job.start()

if app.settings.env == 'production' or process.env.DEBUG_BUILD == 'local'
  require './build'



console.log "Express server listening on port %d in %s mode",
  process.env.PORT || config.port, app.settings.env

app.listen process.env.PORT || config.port