var express = require('express');
var router = express.Router();
var mongoose = require('mongoose');
var moment = require('moment');
var async = require('async');

var Reservaties = mongoose.model('Reservatie');
var Winkels = mongoose.model('Winkel');

/* GET home page. */
router.get('/', function(req, res) {
  res.json(({'Gebruik': 'Testen van Springkasteel REST service'}))
});

router.get('/api', function(req, res) {
  res.json(({'Gebruik': 'Testen van Springkasteel REST service'}))
});

router.get('/api/winkels', function(req,res) {
  Winkels.find({}, function(err, winkels) {
    if(err) {
      console.log(err)
    }
    res.json(winkels)
  })
});

router.get('/api/reservaties/:id', function(req, res) {
  var hash = req.params.id;
  Reservaties.find({'hash': hash},{_id: 0, hash: 0}, function(err, reservaties) {
    if(err) {console.log(err)};
    res.json(reservaties)
  })
});

router.post('/api/winkels', function(req, res, next) {
  var datumRes = req.body.datum;
  var winkelid = req.body.winkelID.toString();

  Reservaties.find({"storeID": winkelid, "datum": datumRes},{ springkasteel: 1, _id: 0}, function(err, resses) {
      res.json(resses)
  });

});

router.post('/api/reservatie', function(req, res) {
  var hashedmail = crypto.createHash('md5').update(req.body.email).digest('hex');
  var email = req.body.email;
  var datum = req.body.datum;
  var storeID = req.body.storeID;
  var termijn = 1;
  var springkasteel = req.body.springkasteel

  Reservaties.insert({"hash": hashedmail, "datum": datum, "email": email, "storeID": storeID, "termijn" :termijn.toString(),
  "springkasteel": springkasteel}, function() {
    res.json({"confirmation": "ok"})
  });
});

module.exports = router;
