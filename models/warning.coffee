mongoose = require('mongoose')
uniqueValidator = require('mongoose-unique-validator')
searchPlugin = require('mongoose-search-plugin')


WarningSchema = new mongoose.Schema(
  '@id':
    type: String, required: true, unique: true
  description: String
  eaAreaName: String
  eaRegionName: String
  floodArea:
    '@id':
      type: String
    county: String
    envelope:
      lowerCorner:
        lx: Number,
        ly: Number

      upperCorner:
        ux: Number,
        uy: Number

    notation: String
    polygon: String
    riverOrSea: String
  floodAreaID: String
  isTidal: Boolean
  message: String
  severity: String
  severityLevel: Number
  timeMessageChanged:
    type: Date
  timeRaised:
    type: Date
  timeSeverityChanged: Date,
  slug:
    type: String, required: true, lowercase: true
)

WarningSchema.plugin(uniqueValidator).plugin(searchPlugin,
  fields: ['description', 'eaAreaName', 'eaRegionName', 'message', 'severity']
)

mongoose.model('Warning', WarningSchema)