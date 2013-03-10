models = require "../models.coffee"
forms = require "forms-mongoose"

TeamModel  = models.TeamModel

exports.index = (req, res) ->
  TeamModel.find (err, teams) ->
    if !err
      res.render './teams/teams'
        title: 'NCAA Tournament Teams'
        layout: 'application'
        nav: 'nav'
        teams: teams
    else
      console.log err
              
exports.show = (req, res) ->
  TeamModel.findById req.params.id, (err, team) ->
    if !err
      res.send team
    else
      console.log err

exports.new = (req, res) ->
  res.render './teams/new'
    title: 'Add a team'
    layout: 'application'
    nav: 'nav'
    regions: ["Midwest", "South", "East", "West"]
    seeds: [1..16]
    
exports.create = (req, res) ->
  console.log "POST: "
  console.log req.body
  team = new TeamModel
    name: req.body.name
    region: req.body.region
    seed: req.body.seed
    price: req.body.price
    owner: req.body.owner
    
  team.save (err) ->
    if !err
      console.log "created"
    else
      console.log err
  # res.send team
  res.redirect 'teams'

exports.edit = (req, res) ->
  TeamModel.findById req.params.id, (err, team) ->
    if !err
      res.render './teams/edit'
        title: 'Edit team'
        layout: 'application'
        nav: 'nav'
        regions: ["Midwest", "South", "East", "West"]
        seeds: [1..16]
        team: team
    else
      console.log err
      
exports.update = (req, res) ->
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
      # res.send team
      res.redirect 'teams'

exports.destroy = (req, res) ->
  TeamModel.findById req.params.id, (err, team) ->
    team.remove (err) ->
      if !err
        console.log "removed"
        res.send "Team with id: #{req.params.id} was deleted\n\n"
      else
        console.log err