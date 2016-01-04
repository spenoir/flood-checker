CronJob = require('cron').CronJob;
app = require('./app')
apiWrapper = require('./GetFloodData')

job = new CronJob(
  cronTime: '58 15 * * *',
  onTick: () ->
    # Runs every day at 00:01:00 AM.
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

console.log "Express server listening on port %d in %s mode", app.settings.port, app.settings.env

app.listen app.settings.port