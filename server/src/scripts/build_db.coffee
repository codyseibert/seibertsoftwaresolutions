require '../db'
models = require '../models/models'
Promise = require 'bluebird'

# Users = models.Users
# Obituaries = models.Obituaries

promises = []

# promises.push Users.create
  # email: 'cseibert113@gmail.com'
  # password: '123456'

Promise.all promises
  .then ->
    process.exit 0
