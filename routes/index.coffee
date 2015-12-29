mongoose = require("mongoose")
express = require("express")
_ = require("underscore")
router = express.Router()
passport = require("passport")

require "./../models/warning"
Warning = mongoose.model("Warning")
basicPageData =
  title: "Flood Warnings"
  slug: "home"


# GET home page. 
router.get "/", (req, res) ->
  context = basicPageData

  warnings = Warning.find().exec((err, warnings) ->
    context = _.extend(context,
      warnings: warnings
    )

    res.render "index", context
    return
  )
  return

router.get "/search/", (req, res) ->
  context = basicPageData
  query = req.query.q
  Warning.setKeywords (err) ->
    if err
      res.status 500
      return res.render "error",
        message: "There was an error when setting the Flavour keywords"

    return

  context = _(context).extend(query: query)

  Warning.search(query, null, null, (err, data) ->
    context = _.extend(context,
      warnings: data.results
    )
    return res.render "search", context
  )
  return

router.get "/login/", (req, res) ->
  res.render "login", _.extend(basicPageData, {req: req})
  return

router.post "/login/", passport.authenticate('local',
  successRedirect: '/'
  failureRedirect: '/login/'
#  failureFlash: true
)


module.exports = router
