request = require('supertest')
should = require('should')

app = require('../app')

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

)