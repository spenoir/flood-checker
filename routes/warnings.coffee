express = require('express')
mongoose = require('mongoose')
_ = require('underscore')
_.str = require('underscore.string')
_.mixin(_.str.exports())
router = express.Router()

require('../models/warning')
Warning = mongoose.model('Warning')

apiWrapper = require('../GetFloodData')

basicPageData =
  title: 'Flood warning checker',
  slug: 'warnings',
  current: false

router.get('/current/', (req, res) ->
  context = basicPageData

  api = new apiWrapper()
  api.makeRequest().then(
    (warnings) ->
      context = _.extend(context,
        warnings: warnings.items,
        current: true
      )
      res.render('warnings', context)
  )

)

router.get('/current/json/', (req, res) ->
  context = basicPageData

  api = new apiWrapper()
  api.makeRequest().then(
    (warnings) ->
      res.json(warnings.items)
  )

)

router.param('warningSlug', (req, res, next, slug) ->
  Warning.findOne({slug: slug}, (err, warning) ->

    if (err)
      return next(err)

    else if (!warning)
      return next(new Error('No warning found for '+ slug))

    req.warning = warning
    return next()
  )
)

router.get('/:warningSlug', (req, res) ->
  context = basicPageData

  _.extend(context,
    warning: req.warning
  )
  res.render('warning', context)
)

router.get('/:warningSlug/json', (req, res) ->
  res.json(req.warning)
)

router.get('/', (req, res) ->
  context = basicPageData

  warnings = Warning.find( (err, warnings) ->
    context = _.extend(context,
      warnings: warnings,
      current: false
    )
    res.render('warnings', context)
  )

)

module.exports = router;
