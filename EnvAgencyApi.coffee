Q = require('q')
request = require('request')
mongoose = require('mongoose')
slug = require('slug')

require('./models/warning')
Warning = mongoose.model('Warning')
_ = require('lodash')

class EnvAgencyApi

  makeRequest: (addWarnings=false) ->
    deferred = Q.defer()
    request(
      'http://environment.data.gov.uk/flood-monitoring/id/floods/?min-severity=2',
      (err, res, body) =>
        if (err)
          deferred.reject(err)

        data = JSON.parse(body)
        deferred.resolve(data)
    )

    return deferred.promise

  findNew: (warnings) ->
    newWarnings = []
    deferred = Q.defer()
    _.each(warnings, (warning, index) ->

      Warning.findOne({'@id': warning['@id']}, (err, model) ->
        if (!model)
          newWarnings.push warning

          if index == (warnings.length - 1)
            if newWarnings.length == 0
              deferred.reject 'There are no new warnings at this time'
            else
              deferred.resolve newWarnings

      )
    )
    return deferred.promise

  newBatch: (warnings) ->

    addSlug = (warning) ->
      warning.slug = slug warning.description
      return warning

    return Warning.create(addSlug(warning) for warning in warnings, (err, warnings) ->
      if err
        console.log err
      return warnings
    )

  newWarning: (warning) ->
    warningModel = new Warning(warning)
    warningModel.slug = slug(warningModel.description)
    console.log("New warning at: #{warningModel.description} from #{warningModel.floodArea.riverOrSea}" )
    return warningModel.save()

module.exports = EnvAgencyApi