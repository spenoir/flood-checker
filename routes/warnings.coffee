express = require('express')
mongoose = require('mongoose')
_ = require('underscore')
_.str = require('underscore.string')
_.mixin(_.str.exports())
router = express.Router()

require('../models/warning')
Warning = mongoose.model('Warning')

apiWrapper = require('../EnvAgencyApi')

basicPageData =
  slug: 'warnings',
  current: false

router.get('/current/json/', (req, res) ->
  context = _(res.context).extend(basicPageData)

  api = new apiWrapper()
  api.makeRequest().then(
    (warnings) ->

      _.extend(context,
        warnings: warnings,
        current: true
      )

      api.findNew(warnings.items).then( (newWarnings) ->
        api.newBatch(newWarnings).then((addedWarnings) ->
          console.log "added #{addedWarnings.length} new warnings"
        )
      ).fail( (err) ->
        console.log err
      )

      res.json(context)
  )

)

router.get('/json/', (req, res) ->
  context = _(res.context).extend(basicPageData)

  warnings = Warning.find( (err, warnings) ->
    context = _.extend(context,
      warnings: warnings,
      current: false
    )
    res.json(context)
  ).sort('-timeRaised')

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
  context = _(res.context).extend(basicPageData)

  _.extend(context,
    warning: req.warning
  )
  res.render('warning', context)
)

router.get('/:warningSlug/json', (req, res) ->
  res.json(req.warning)
)

module.exports = router;
