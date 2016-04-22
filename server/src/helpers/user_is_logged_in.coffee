Base64 = require('js-base64').Base64
Users = require('../models/models').Users

module.exports = (req, res, next) ->
  auth = req.headers.authorization

  if not auth?
    res.status 400
    res.send 'invalid authorization header'
    return

  auth = auth.split(" ")
  if auth.length isnt 2
    res.status 400
    res.send 'invalid authorization header'
    return

  creds = auth[1]
  creds = Base64.decode creds
  creds = creds.split ':'
  if creds.length isnt 2
    res.status 400
    res.send 'invalid creditials passed'
    return

  query =
    email: creds[0]
    password: creds[1]
  Users.findOne(query).then (results) ->
    if not results?
      res.status 403
      res.send 'invalid login'
    else
      req.user = results
      next()
