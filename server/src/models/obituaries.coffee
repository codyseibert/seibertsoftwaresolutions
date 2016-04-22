mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

module.exports = new Schema
  user_id: ObjectId
  name: String
  breed: String
  date_of_birth: Date
  date_of_death: Date
  biography: String
  images: Array
  stories: Array
