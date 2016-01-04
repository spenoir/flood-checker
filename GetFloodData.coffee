Q = require('q')
request = require('request')
mongoose = require('mongoose')
slug = require('slug')

require('./models/warning')
Warning = mongoose.model('Warning')

class EnvAgencyApi
  constuctor: (@name) ->

  makeRequest: ->
    deferred = Q.defer()
    request(
      'http://environment.data.gov.uk/flood-monitoring/id/floods/?min-severity=2',
      (err, res, body) ->
        if (err)
          return deferred.reject(err)

        return deferred.resolve(JSON.parse(body))
    )
    return deferred.promise

  newBatch: (warnings) ->
    addSlug = (warning) ->
      warning.slug = slug(warning.description)
      return warning

    return Warning.create(addSlug(warning) for warning in warnings)

  newWarning: (warning) ->
    warningModel = new Warning(warning)
    warningModel.slug = slug(warningModel.description)
    console.log("New warning at: #{warningModel.description} from #{warningModel.floodArea.riverOrSea}" )
    return warningModel.save()

module.exports = EnvAgencyApi