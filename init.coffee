CronJob = require('cron').CronJob;
app = require('./app')

#job = new CronJob(
#  cronTime: '00 01 00 * *',
#  onTick: () ->
#     # Runs every day at 00:01:00 AM.
#  ,
#  start: false,
#  timeZone: 'Europe/London'
#)
#job.start()

console.log "Express server listening on port %d in %s mode", app.settings.port, app.settings.env

app.listen app.settings.port