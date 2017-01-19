// Mongoose model voor reservatie

var mongoose = require('mongoose');

var ReservatieSchema = new mongoose.Schema({
    datum: String,
    voornaam: String,
    familienaam: String,
    email: String,
    eidnr: String,
    storeID: String,
    termijn: Number,
    springkasteel: String
});

mongoose.model('Reservatie', ReservatieSchema);

module.exports = mongoose;