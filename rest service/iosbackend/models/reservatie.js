// Mongoose model voor reservatie

var mongoose = require('mongoose');

var ReservatieSchema = new mongoose.Schema({
    datum: String,
    email: String,
    storeID: String,
    termijn: Number,
    springkasteel: String
});

mongoose.model('Reservatie', ReservatieSchema);

module.exports = mongoose;
