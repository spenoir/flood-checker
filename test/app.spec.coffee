request = require('supertest')
should = require('should')

app = require('../app')

describe('app', ->

  agent = request.agent(app);

  it('should load warnings route', (done) ->

    agent
    .get('/warnings/')
    .expect(200, done)
  )

)