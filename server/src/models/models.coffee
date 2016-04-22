mongoose = require 'mongoose'

module.exports =
  Users: mongoose.model 'Users', require './users'
  Obituaries: mongoose.model 'Obituaries', require './obituaries'
