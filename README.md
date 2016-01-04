# README #

## Installation

  `npm install`
  `jspm install`

## Running in JS

  `DEBUG=eliquid-calculator nodemon ./bin/www`

## Running with coffee

  `node-debug app.coffee`
  
## Running tests
  `grunt` or `grunt mochaTest`
  
## Run tests with debug  
  `node-debug $(which grunt) mochaTest`

A stackoverflow link for [debugging with coffee http://stackoverflow.com/questions/27754053/invoking-the-coffeescript-repl]

## Flood data research

### Api link to all Flood warnings

http://environment.data.gov.uk/flood-monitoring/id/floods/?min-severity=2

### Example of specific location lookup

http://environment.data.gov.uk/flood-monitoring/id/floods/?lat=54.601276&long=-3.134706&dist=20&min-severity=2

