request = require('supertest')
should = require('should')

app = require('../app')
apiWrapper = require('../GetFloodData')

describe('app', ->
  beforeEach () ->
    @agent = request.agent(app);

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