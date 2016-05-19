var express = require('express');
var router = express.Router();
var usersDal = require('../model/users_dal');

/* GET users listing. */
router.get('/', function(req, res, next) {
  res.send('respond with a resource');
});

router.get('/create', function(req, res) {
  res.render('userFormCreate.ejs');
});

router.get('/save', function(req, res) {
  usersDal.Insert(req.query, function(err, result){
    if (err) {
      res.send(err);
    }
    else {
      res.send("Successfully saved the user.");
    }
  });
});

module.exports = router;
