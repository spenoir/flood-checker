utils = require('./utils')

should = require('should')
mongoose = require('mongoose')

apiWrapper = require('../EnvAgencyApi')
require('../models/warning')
Warning = mongoose.model('Warning')

exampleWarning =
  '@id': "http://environment.data.gov.uk/flood-monitoring/id/floods/93479"
  description: "Keswick Campsite"
  eaAreaName: "North"
  eaRegionName: "North West"
  floodArea:
    '@id': "http://environment.data.gov.uk/flood-monitoring/id/floodAreas/011FWFNC6KC"
    county: "Cumbria"
    notation: "011FWFNC6KC"
    polygon: "http://environment.data.gov.uk/flood-monitoring/id/floodAreas/011FWFNC6KC/polygon"
    riverOrSea: "Derwentwater"
  floodAreaID: "011FWFNC6KC"
  isTidal: false
  message: "
      Heavy rain overnight will continue through this morning causing lake levels to rise through the Flood Warning trigger.
      The weather situation is due to improve but the lake level will remain high.  We will continue to monitor the situation and will update should the situation change."
  severity: "Flood Warning"
  severityLevel: 2
  timeMessageChanged: "2015-12-30T07:02:00"
  timeRaised: "2015-12-30T07:02:00"
  timeSeverityChanged: "2015-12-30T07:02:00"

describe('Environment Agency API wrapper', ->

  it('should get raw api json', (done) ->

    api = new apiWrapper()

    api.makeRequest().then( (response) ->
      response.meta.publisher.should.equal("Environment Agency")
      done()
    )

  )

  it('should save a new warning', (done) ->

    api = new apiWrapper()

    warning = api.newWarning(exampleWarning)

    warning.then( (model) ->
      Warning.findOne(
        slug: 'keswick-campsite'
        , (err, warning) ->
          should.exist(warning)
          done()
      )
    )

  )

#  it('should find new warnings', (done) ->
#    api = new apiWrapper()
#    api.makeRequest().then( (response) ->
#      api.findNew(response.items).then((newWarnings) ->
#        debugger
#        api.newBatch(newWarnings).then((addedWarnings) ->
#
#          addedWarnings.length.should.greaterThan(1)
#          done()
#        ).fail((err) ->
#          err.should.equal('There are no new warnings at this time')
#        )
#      )
#    )
#  )

#  it('should save new warnings', (done) ->
#
#    api = new apiWrapper()
#
#    api.makeRequest(false).then(
#      (warnings) ->
#        api.findNew(warnings.items).then( (newWarnings) ->
#
#          api.newBatch(newWarnings).then( (models) ->
#            Warning.find({}, (err, foundWarnings) ->
#              debugger
#              foundWarnings.length.should.greaterThan(1)
#
#              done()
#            )
#          )
#
#        )
#
#    )
#
#  )

#  it('should save new warnings when addWarnings true', (done) ->
#
#    api = new apiWrapper()
#
#    api.makeRequest(true).then(
#      (warnings) ->
#
#        debugger
#        Warning.find({}, (err, models) ->
#          models.length.should.equal(warnings.length)
#
#          done()
#        )
#    )
#
#  )

#  it('should handle no new warnings', (done) ->
#
#    api = new apiWrapper()
#
#    api.makeRequest(false).then(
#      (warnings) ->
#        api.newBatch(warnings.items).then( (models) ->
#          Warning.find({}, (err, warnings) ->
#            warnings.length.should.greaterThan(1)
#          )
#        )
#
#        api.newBatch(warnings.items).then( (models) ->
#          Warning.find({}, (err, warnings) ->
#            debugger
#            done()
#          )
#        )
#    )
#
#  )

)
