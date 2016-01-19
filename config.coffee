config =
  db:
    default: 'mongodb://localhost/flood-checker'
    test: 'mongodb://localhost/flood-checker-test'
  port: 3000
  title: 'Flood warning checker'
  defaultContext:
    title: 'Flood warning checker'

module.exports = config