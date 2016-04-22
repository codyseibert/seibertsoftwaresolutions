Base64 = require('js-base64').Base64
Users = require('../models/models').Users
Obituaries = require('../models/models').Obituaries

module.exports = (req, res, next) ->

  obituaryId = req.id

  Obituaries.findById(obituaryId).then (obituary) ->
    if not obituary?
      res.status 400
      res.send 'You do not have access to this obituary'
    else
      next()
