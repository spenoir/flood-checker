#!/usr/bin/env coffee

apiWrapper = require './EnvAgencyApi'

console.log "getting new warnings"
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