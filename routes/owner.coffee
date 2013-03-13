models = require "../models.coffee"

OwnerModel = models.OwnerModel
teams = models.TeamModel

exports.index = (req, res) ->
  # res.render 'owners', title: 'Owners', owners: owners
  OwnerModel.find (err, owners) ->
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
      if owner.points > 50
        points_style = 'text-info'
      else if owner.points < 25
        points_style = 'text-error'
      else
        points_style = 'text-warning'
        
      res.render './owners/show'
        layout: 'application'
        nav: 'nav'
        owner: owner
        points_style: points_style
        
    else
      console.log err

exports.new = (req, res) ->
  res.render './owners/new'
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
      res.render './owners/edit'
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
        res.redirect 'owners'
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