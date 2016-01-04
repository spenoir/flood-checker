config
  db:
    default: 'mongodb://localhost/flood-checker'
    test: 'mongodb://localhost/flood-checker-test'
  port: 3000

if process.env.NODE_ENV == 'production'
  config.port = 80

module.exports = config