mongoose = require "mongoose"
express = require "express"
_ = require "underscore"
router = express.Router()

require "./../models/warning"
Warning = mongoose.model "Warning"
config = require '../config'


router.get "/", (req, res) ->
  res.render "index", res.context

router.get "/search/json/", (req, res) ->
  query = req.query.q
  Warning.setKeywords (err) ->
    if err
      res.status 500
      return res.render "error",
        message: "There was an error when setting the Warning keywords"


  _(res.context).extend(query: query)

  Warning.search(query, null, null, (err, data) ->
    _.extend(res.context,
      warnings: data.results
    )
    return res.json(res.context)
  )


module.exports = router
