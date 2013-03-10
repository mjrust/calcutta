models = require "../models.coffee"

OwnerModel = models.OwnerModel

exports.index = (req, res) ->
  # res.render 'owners', title: 'Owners', owners: owners
  OwnerModel.find (err, owners) ->
    if !err
      res.send owners
    else
      console.log err

exports.show = (req, res) ->
  OwnerModel.findById req.params.id, (err, owner) ->
    if !err
      res.send owner
    else
      console.log err

exports.new = (req, res) ->
  console.log "POST: "
  console.log req.body
  owner = new OwnerModel
    name: req.body.name
    owner: req.body.owner
  owner.save (err) ->
    if !err
      console.log "created"
    else
      console.log err
  res.send owner

exports.edit = (req, res) ->
  OwnerModel.findById req.params.id, (err, owner) ->
    if !err
      res.render 'show',
        title: 'Viewing owner' + owner
        owner: owner
    else
      console.log err

exports.update = (req, res) ->
  OwnerModel.findById req.params.id, (err, owner) ->
    owner.name = req.body.name
    owner.owner = req.body.owner
    owner.save (err) ->
      if !err
        console.log "updated"
        res.send "Team with id: #{req.params.id} was updated\n\n"
      else
        console.log "error"
        console.log err
      # res.send owner
      res.redirect 'back'

exports.destroy = (req, res) ->
  OwnerModel.findById req.params.id, (err, owner) ->
    owner.remove (err) ->
      if !err
        console.log "removed"
        res.send "Team with id: #{req.params.id} was deleted\n\n"
      else
        console.log err
        
exports.name = (req, res) ->
  OwnerModel.find name: req.params.name, (err, owner) ->
    if !err
      res.send owner
    else
      console.log err