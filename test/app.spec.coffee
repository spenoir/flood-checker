request = require('supertest')
should = require('should')

app = require('../app')
apiWrapper = require('../EnvAgencyApi')

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

describe('app', ->
  beforeEach () ->
    @agent = request.agent(app);

  it('should load json on search route', (done) ->

    api = new apiWrapper()

    warning = api.newWarning(exampleWarning)

    warning.then( (model) ->
      Warning.findOne(
        slug: 'keswick-campsite'
        , (err, warning) ->
          should.exist(warning)

          @agent
          .get('/search/')
          .expect(200, done)
      )
    )
  )

#  it('should load search route', (done) ->
#
#    @agent
#    .get('/search/')
#    .expect(200, done)
#  )

  it('should load warnings route', (done) ->

    @agent
    .get('/warnings/')
    .expect(200, done)
  )

  it('should load home route', (done) ->

    @agent
    .get('/')
    .expect(200, done)
  )

  it('should load current warnings json', (done) ->
    @agent
      .get('/warnings/current/json/')
      .expect(200, done)

  )

)