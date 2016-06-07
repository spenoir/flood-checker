# Flood warnings checker

This app uses the following technologies: 
SystemJS, jspm, CoffeeScript, NodeJS, MongoDB, Mongoose, Angular, Bootstrap CSS, 
Angular UI, Mocha

It is influenced by [angular-systemjs-seed](https://github.com/Swimlane/angular-systemjs-seed)

## Installation

  `npm install`
  
## Running tests
  `grunt` or `grunt mochaTest`
  
## Run tests with debug  
  `node-debug $(which grunt) mochaTest`

## Flood data links

### Api link to all Flood warnings

[Environment Agency Api](http://environment.data.gov.uk/flood-monitoring/id/floods/)

### Example of specific location lookup

[Specific location](http://environment.data.gov.uk/flood-monitoring/id/floods/?lat=54.601276&long=-3.134706&dist=20&min-severity=2)

