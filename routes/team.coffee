models = require "../models.coffee"

TeamModel  = models.TeamModel
owners = models.OwnerModel

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
    owners: ["", "Rust", "Dowd", "Al", "Eugene", "Kyle", "Mac", "Jonathon", "Phil", "Kevin", "Woodburn", "Pete", "Joe"]
    
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
      req.flash 'info', 'Team successfully created!'
      res.redirect 'teams'
    else
      req.flash 'error', 'Team was not created due to an error.'
      console.log err
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
        owners: ["", "Rust", "Dowd", "Al", "Eugene", "Kyle", "Mac", "Jonathon", "Phil", "Kevin", "Woodburn", "Pete", "Joe"]
        team: team
    else
      console.log err
      
exports.update = (req, res) ->
  TeamModel.findById req.params.id, (err, team) ->
    team.name = req.body.name
    team.region = req.body.region
    team.seed = req.body.seed
    team.price = req.body.price
    team.owner = req.body.owner
    team.save (err) ->
      if !err
        console.log "updated"
        req.flash 'info', 'Team successfully updated!'
        # res.send "Team with id: #{req.params.id} was updated\n\n"
        res.redirect 'teams'
      else
        console.log "error"
        console.log err
        res.redirect 'teams'
      
exports.destroy = (req, res) ->
  TeamModel.findById req.params.id, (err, team) ->
    team.remove (err) ->
      if !err
        console.log "removed"
        res.send "Team with id: #{req.params.id} was deleted\n\n"
      else
        console.log err