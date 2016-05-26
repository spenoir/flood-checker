#!/usr/bin/env coffee

Builder = require 'systemjs-builder'

builder = new Builder 'frontend', 'frontend/system.config.js'

builder
  .buildStatic 'main.js', 'frontend/prod.js', minify: true, mangle: false
  .then () ->
    console.log 'Build complete'

  .catch (err) ->
    console.log 'Build error'
    console.log err


module.exports = builder