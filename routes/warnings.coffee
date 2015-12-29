express = require('express')
mongoose = require('mongoose')
_ = require('underscore')
_.str = require('underscore.string')
_.mixin(_.str.exports())
router = express.Router()

require('./../models/warning')

Warning = mongoose.model('Warning')

basicPageData =
  title: 'Flood warning checker',
  slug: 'warnings'

router.param('warning-slug', (req, res, next, slug) ->
  Warning.find({slug: slug}, (err, warning) ->

    if (err)
      return next(err)

    else if (!warning)
      return next(new Error('No warning found for '+ slug))

    req.warning = warning
    return next()
  )
)

router.get('/', (req, res) ->
  context = basicPageData

  warnings = Warning.find( (err, warnings) ->
    context = _.extend(context,
      warnings: warnings
    )
    res.render('warnings', context)
  )

)


module.exports = router;
