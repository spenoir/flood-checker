var mongoose = require('mongoose');
var uniqueValidator = require('mongoose-unique-validator');

var UserSchema = new mongoose.Schema({
  firstName: {type: String, required: true},
  lastName: {type: String, required: true},
  username: {type: String, required: true, unique: true, lowercase: true},
  password: {type: String, required: true}
});
UserSchema.plugin(uniqueValidator);

mongoose.model('User', UserSchema);