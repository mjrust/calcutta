require('coffee-script')

express  = require "express"
mongoose = require "mongoose"
cons     = require "consolidate"
partials = require "express-partials"

# Database
db = mongoose.connect('mongodb://localhost/calcutta')
app = express()

app.configure () ->
  app.use express.logger('dev')  # 'default', 'short', 'tiny', 'dev'
  app.engine 'eco', cons.eco
  app.set 'view engine', 'eco'
  app.use partials()
  app.use express.static(__dirname + '/public')
  app.set 'views', __dirname + '/views'
  app.use express.bodyParser()

Schema = mongoose.Schema

# NCAA teams
Team = new Schema
  name: type: String, required: true
  modified: type: Date, default: Date.now

TeamModel = mongoose.model('Team', Team)

# Calcutta owner
Owner = new Schema
  name: type: String, required: true
  teams: [Team]
  modified: type: Date, default: Date.now

OwnerModel = mongoose.model('Owner', Owner)

app.get '/', (req, res) ->
  res.render 'admin', title: 'Calcutta', name: 'Matt Rust', layout: 'application', nav: 'nav', form: 'form'

app.get '/teams', (req, res) ->
  TeamModel.find (err, teams) ->
    if !err
      res.send teams
    else
      console.log err

app.get '/team/:id', (req, res) ->
  TeamModel.findById req.params.id, (err, team) ->
    if !err
      res.send team
    else
      console.log err

app.post '/team', (req, res) ->
  console.log "POST: "
  console.log req.body
  team = new TeamModel
    name: req.body.name
    owner: req.body.owner
  team.save (err) ->
    if !err
      console.log "created"
    else
      console.log err
  res.send team

app.put '/team/:id', (req, res) ->
  TeamModel.findById req.params.id, (err, team) ->
    team.name = req.body.name
    team.owner = req.body.owner
    team.save (err) ->
      if !err
        console.log "updated"
        res.send "Team with id: #{req.params.id} was updated\n\n"
      else
        console.log "error"
        console.log err
      res.send team

app.del '/team/:id', (req, res) ->
  TeamModel.findById req.params.id, (err, team) ->
    team.remove (err) ->
      if !err
        console.log "removed"
        res.send "Team with id: #{req.params.id} was deleted\n\n"
      else
        console.log err

app.get '/owners', (req, res) ->
  OwnerModel.find (err, owners) ->
    if !err
      res.send owners
    else
      console.log err

app.get '/owner/:id', (req, res) ->
  OwnerModel.findById req.params.id, (err, owner) ->
    if !err
      res.send owner
    else
      console.log err
      
app.get '/owner/name/:name', (req, res) ->
  OwnerModel.find name: req.params.name, (err, owner) ->
    if !err
      res.send owner
    else
      console.log err

app.post '/owner', (req, res) ->
  console.log "POST: "
  console.log req.body
  owner = new OwnerModel
    name: req.body.name
  for team in req.body.teams
    owner.teams.push team
  owner.save (err) ->
    if !err
      console.log "created"
    else
      console.log err
  res.send owner

app.put '/owner/:id', (req, res) ->
  OwnerModel.findById req.params.id, (err, owner) ->
    owner.name = req.body.name
    for team in req.body.teams
      owner.teams.push team
    owner.save (err) ->
      if !err
        console.log "updated"
        res.send "Owner with id: #{req.params.id} was updated\n\n"
      else
        console.log "error"
        console.log err
      res.send owner

app.del '/owner/:id', (req, res) ->
  OwnerModel.findById req.params.id, (err, owner) ->
    owner.remove (err) ->
      if !err
        console.log "removed"
        res.send "Owner with id: #{req.params.id} was deleted\n\n"
      else
        console.log err


app.listen 3005
console.log 'Listening on port 3005'
