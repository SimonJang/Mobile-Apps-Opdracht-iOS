var express = require('express');
var router = express.Router();
var mongoose = require('mongoose');

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

router.get('/api/winkels/:id', function(req, res) {
  
});

module.exports = router;
