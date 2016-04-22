models = require '../models/models'
Snippits = models.Snippits
ObjectId = require('mongoose').Types.ObjectId
lodash = require 'lodash'
classifier = require 'language-classifier'
log4js = require 'log4js'
logger = log4js.getLogger 'app'

module.exports = do ->

  index: (req, res) ->
    query = req.query
    if req.query['_id$in']
      query =
        '_id':
          $in: req.query['_id$in'].split ','
    Snippits.find(query).then (obj) ->
      res.status 200
      res.send obj

  show: (req, res) ->
    Snippits.findById(req.params.id).then (obj) ->
      res.status 200
      res.send obj

  post: (req, res) ->
    req.body.user_id = req.user._id
    # req.body.language = classifier req.body.code
    Snippits.create(req.body).then (obj) ->
      res.status 200
      res.send obj

  put: (req, res) ->
    Snippits.update(_id: new ObjectId(req.params.id), req.body).then (obj) ->
      res.status 200
      res.send obj

  destroy: (req, res) ->
    Snippits.findById(req.params.id).remove().then (obj) ->
      res.status 200
      res.send obj
