express = require "express"
path = require "path"
favicon = require "serve-favicon"
logger = require "morgan"
cookieParser = require "cookie-parser"
bodyParser = require "body-parser"
sassMiddleware = require "node-sass-middleware"
session = require 'express-session'
_ = require 'underscore'

config = require './config'

mongoose = require "mongoose"

user = process.env.MONGO_USER
pwd = process.env.MONGO_PWD


if process.env.NODE_ENV is 'production'
  mongoose.connect(process.env.MONGOLAB_URI,
    user: user
    pass: pwd
  )
else
  mongoose.connect(config.db.default)

flash = require 'connect-flash'
routes = require("./routes/index")
routesWarnings = require("./routes/warnings")

require('./models/warning')
require('./models/user')

Warning = mongoose.model("Warning")

app = express()

publicDir = "#{__dirname}/public"
sassDir = "#{__dirname}/sass"
viewsDir  = "#{__dirname}/views"

# view engine setup
app.set "views", viewsDir
app.set "view engine", "jade"

if process.env.NODE_ENV is 'production' or process.env.NODE_ENV is 'debug-build'
  console.log "running in production mode #{process.env.NODE_ENV}"
else
  app.disable "view cache"


#app.use(favicon(__dirname + '/public/favicon.ico'));
app.use logger("dev")
app.use bodyParser.json()
app.use bodyParser.urlencoded(extended: false)
app.use cookieParser()
app.use flash()

sassOptions =
  src: sassDir
  dest: publicDir
  debug: true
  force: true
  outputStyle: "expanded"
  sourceComments: true
  prefix: '/static/'
  includePaths: [
    __dirname + "/bower_components/bootstrap-sass-official/assets/stylesheets/"
    __dirname + "/bower_components/compass-breakpoint/stylesheets/"
  ]

app.use sassMiddleware(
  sassOptions
)

app.use '/static/', express.static(path.join(__dirname, "public"))
app.use '/frontend/', express.static(path.join(__dirname, "frontend"))

app.use (req, res, next) ->
  res.env = app.settings.env
  res.context = _(config.defaultContext).extend(env: res.env)
  next()

app.use "/", routes
app.use "/warnings", routesWarnings
app.locals._ = require 'underscore'
app.locals.moment = require 'moment'
app.locals.JSON = JSON

# catch 404 and forward to error handler
app.use (req, res, next) ->
  err = new Error("Not Found")
  err.status = 404
  next err


# error handlers

# development error handler
# will print stacktrace
if app.get("env") is "development"
  app.use (err, req, res, next) ->

    res.status err.status or 500
    context = _.extend(res.context,
      message: err.message
      error: err
    )
    res.render "error", context

# production error handler
# no stacktraces leaked to user
app.use (err, req, res, next) ->

  res.status err.status or 500
  context = _.extend(res.context,
    message: err.message
    error: err
  )
  res.render "error", context


module.exports = app