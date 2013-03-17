models = require "../models.coffee"

OwnerModel = models.OwnerModel
teams = models.TeamModel

# Load configurations
io       = require "socket.io"
http     = require "http"

# app = express()
server = http.createServer()
io = io.listen(server)
server.listen 3004

io.sockets.on 'connection', (socket) ->
  console.log "CONNECTED"

exports.index = (req, res) ->
  
  OwnerModel.find (err, owners) ->
    for owner in owners
      if owner.points > 50
        owner.points_style = 'text-success'
      else if owner.points < 25
        owner.points_style = 'text-error'
      else
        owner.points_style = 'text-warning'
        
    if !err
      res.render './owners/owners'
        title: 'The Sirs'
        layout: 'application'
        nav: 'nav'
        owners: owners
      
    else
      console.log err

exports.show = (req, res) ->
  OwnerModel.findById req.params.id, (err, owner) ->
    
    if !err
      res.send owner  
    else
      console.log err

exports.new = (req, res) ->
  res.render './owners/new_owner'
    title: 'Add an owner'
    layout: 'application'
    nav: 'nav'
    teams: teams

exports.create = (req, res) ->
  owner = new OwnerModel
    name: req.body.name
    
  owner.save (err) ->
    if !err
      console.log "created"
      req.flash 'info', 'Owner successfully created!'
      res.redirect 'owners'
    else
      req.flash 'error', 'Owner was not created due to an error.'
      console.log err
      res.redirect 'owners'

exports.edit = (req, res) ->
  OwnerModel.findById req.params.id, (err, owner) ->
    if !err
      res.render './owners/edit_owner'
        title: 'Edit owner'
        layout: 'application'
        nav: 'nav'
        owner: owner
    else
      console.log err

exports.update = (req, res) ->
  OwnerModel.findById req.params.id, (err, owner) ->
    owner.name = req.body.name
    owner.points = req.body.points
    owner.save (err) ->
      if !err
        console.log "updated"
        req.flash 'info', 'Owner successfully updated!'
        res.redirect 'owners', io.sockets.emit "owner:changed"
      else
        console.log "error"
        console.log err
        res.redirect 'back'

exports.destroy = (req, res) ->
  OwnerModel.findById req.params.id, (err, owner) ->
    owner.remove (err) ->
      if !err
        console.log "removed"
        res.send "Owner with id: #{req.params.id} was deleted\n\n"
      else
        console.log err
        
exports.name = (req, res) ->
  OwnerModel.findOne name: req.params.name, (err, owner) ->
    if !err
      res.render './owners/show'
        layout: 'application'
        nav: 'nav'
        owner: owner
    else
      console.log err