require('coffee-script')

# Load configurations
express  = require "express"
mongoose = require "mongoose"
cons     = require "consolidate"
partials = require "express-partials"
team     = require "./routes/team"
owner    = require "./routes/owner"
app = express()

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
app.get '/owner/name/:name', owner.name
app.post '/owner', owner.new
app.get '/owner/:id/edit', owner.edit
app.put '/owner/:id', owner.update
app.del '/owner/:id', owner.destroy


app.listen 3005
console.log 'Listening on port 3005'
