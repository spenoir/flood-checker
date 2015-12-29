express = require("express")
path = require("path")
favicon = require("serve-favicon")
logger = require("morgan")
cookieParser = require("cookie-parser")
bodyParser = require("body-parser")
sassMiddleware = require("node-sass-middleware")
session = require('express-session')

mongoose = require("mongoose")
mongoose.connect("mongodb://localhost/flood-checker")

flash = require('connect-flash')
passport = require("passport")
LocalStrategy = require("passport-local").Strategy

routes = require("./routes/index")
routesWarnings = require("./routes/warnings")

require('./models/warning')
require('./models/user')

User = mongoose.model("User")
Warning = mongoose.model("Warning")

coffeeMiddleware = require('coffee-middleware')

app = express()

publicDir = "#{__dirname}/public"
viewsDir  = "#{__dirname}/views"
coffeeDir = "#{viewsDir}/coffeescript"

# view engine setup
app.set "views", viewsDir
app.set "view engine", "jade"
app.settings.port = 3000

# uncomment after placing your favicon in /public
#app.use(favicon(__dirname + '/public/favicon.ico'));
app.use logger("dev")
app.use bodyParser.json()
app.use bodyParser.urlencoded(extended: false)
app.use cookieParser()
#app.use session(
#  secret: 'keyboard cat'
#  cookie:
#    maxAge: 60000
#)
app.use flash()

app.use coffeeMiddleware(
  src: __dirname + '/coffee'
  compress: true
)

app.use sassMiddleware(
  src: __dirname + "/sass/"
  dest: __dirname + "/public"
  debug: true
  force: true
  outputStyle: "compact"
  sourceComments: true
  includePaths: [__dirname + "/bower_components/bootstrap-sass-official/assets/stylesheets/"]
)
app.use express.static(path.join(__dirname, "public"))
app.use passport.initialize()
app.use passport.session()
app.use "/", routes
app.use "/warnings", routesWarnings
app.locals._ = require("underscore")

passport.authenticate('local', failureFlash: 'Incorrect Username or Password!' )

# MIDDLEWARE
passport.use new LocalStrategy (username, password, done) ->
  User.findOne
    username: username,
    (err, user) ->
      return done(err) if err
      unless user
        return done(null, false,
          message: "Incorrect username."
        )
      if user.validate().errors
        console.log errors
        return done(null, false,
          message: "Incorrect password."
        )
      done null, user

  return

passport.serializeUser (user, done) ->
  done null, user.id

passport.deserializeUser (user, done) ->
  User.findById id, (err, user) ->
    done err, user


# catch 404 and forward to error handler
app.use (req, res, next) ->
  err = new Error("Not Found")
  err.status = 404
  next err
  return


# error handlers

# development error handler
# will print stacktrace
if app.get("env") is "development"
  app.use (err, req, res, next) ->
    res.status err.status or 500
    res.render "error",
      message: err.message
      error: err

    return


# production error handler
# no stacktraces leaked to user
app.use (err, req, res, next) ->
  res.status err.status or 500
  res.render "error",
    message: err.message
    error: {}

  return


module.exports = app
#app.listen app.settings.port
#console.log "Express server listening on port %d in %s mode", app.settings.port, app.settings.env