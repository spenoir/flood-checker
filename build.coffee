Builder = require 'systemjs-builder'

builder = new Builder 'frontend', 'frontend/system.config.js', { minify: true }

builder
  .bundle 'main.js', 'frontend/prod.js'
  .then () ->
    console.log 'Build complete'

  .catch (err) ->
    console.log 'Build error'
    console.log err


module.exports = builder