app = require './app'

multer = require 'multer'
upload = multer dest: '/tmp'

module.exports = do ->
