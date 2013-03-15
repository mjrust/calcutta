require('coffee-script')

# Load configurations
express  = require "express"
mongoose = require "mongoose"
cons     = require "consolidate"
partials = require "express-partials"
team     = require "./routes/team"
owner    = require "./routes/owner"
flash    = require "connect-flash"
io       = require "socket.io"
http     = require "http"

app = express()
server = http.createServer(app)
io = require("socket.io").listen(server)
server.listen 3005
# Database
db = mongoose.connect('mongodb://localhost/calcutta')

# App configurations
app.configure () ->
  app.use express.logger('dev')  # 'default', 'short', 'tiny', 'dev'
  app.engine 'eco', cons.eco
  app.set 'view engine', 'eco'
  app.use partials()
  app.use express.static(__dirname + '/public')
  app.set 'views', __dirname + '/views'
  app.use express.bodyParser()
  app.use express.cookieParser()
  app.use express.session(secret: 'dsalkfjhsdeuwtyoqweibvcxdfhawueqtoqigkjdahsgfbcmzv', key: 'sid', cookie: maxAge: 60000 )
  app.use express.methodOverride()
  app.use flash()
  app.use require('connect-assets')()
  app.use (req, res, next) ->
    res.locals.message = req.flash()
    next()

# app.all '/admin/*', requireAuthentication
app.get '/', (req, res) ->
  res.render 'index', title: 'Calcutta', name: 'Matt Rust', layout: 'application', nav: 'nav', form: 'form'
app.get '/teams', team.index
app.get '/team/:id', team.show
app.get '/teams/new', team.new
app.post '/teams/create', team.create
app.get '/team/:id/edit', team.edit
app.put '/team/:id', team.update
app.del '/team/:id', team.destroy
app.get '/owners', owner.index
app.get '/owner/:id', owner.show  
app.get '/owners/name/:name', owner.name
app.get '/owners/new', owner.new
app.post '/owners/create', owner.create
app.get '/owner/:id/edit', owner.edit
app.put '/owner/:id', owner.update
app.del '/owner/:id', owner.destroy

app.listen 3005
console.log 'Listening on port 3005'

io.sockets.on 'connection', (socket) ->
  console.log "CONNECTED"
  # io.sockets.emit "owner:changed"
