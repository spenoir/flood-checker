CronJob = require('cron').CronJob
app = require('./app')
apiWrapper = require('./GetFloodData')
config = require('./config')

job = new CronJob(
  cronTime: '43 14 * * *'
  onTick: () ->
    # Runs every day
    api = new apiWrapper()
    api.makeRequest().then(
      (warnings) ->
        api.newBatch(warnings.items).then( (models) ->
          console.log("Added #{models.length} new warnings")
          Warning.find({}, (err, warnings) ->
            console.log("Total warnings: #{warnings.length}")
          )

        )
    )
  ,
  start: false,
  timeZone: 'Europe/London'
)
job.start()

console.log "Express server listening on port %d in %s mode", config.port, app.settings.env

app.listen process.env.PORT || config.port