mongoose = require "mongoose"
Schema = mongoose.Schema

# NCAA teams
Team = new Schema
  name: type: String, required: true
  region: String
  seed: Number
  price: type: Number, default: 0
  owner: type: String, default: 'none'

# Calcutta owners
Owner = new Schema
  name: type: String, required: true
  teams: [Team]
  points: type: Number, default: 100

module.exports.TeamModel  = mongoose.model('Team', Team)  
module.exports.OwnerModel = mongoose.model('Owner', Owner)