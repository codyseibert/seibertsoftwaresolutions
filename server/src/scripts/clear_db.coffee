require '../db'
models = require '../models/models'
Promise = require 'bluebird'
mongoose = require 'mongoose'

promises = []
setTimeout ->
  # promises.push mongoose.connection.collections['users'].drop()
, 2000

setTimeout ->
  process.exit 0
, 4000
