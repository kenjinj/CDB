var express = require('express');
var router = express.Router();
var usersDal = require('../model/users_dal');

/* GET home page. */
router.get('/', function(req, res, next) {
  var data = {
    title : 'Express'
  }
  if(req.session.account === undefined) {
    res.render('index', data);
  }
  else {
    data.firstname = req.session.account.firstname;
    res.render('index', data);
  }
});

router.get('/login', function(req, res) {
  res.render('authentication/login.ejs');
});

router.get('/logout', function(req, res) {
  req.session.destroy( function(err) {
    res.render('authentication/logout.ejs');
  });
});

router.get('/about', function(req, res) {
  res.render('about.ejs');
});

router.get('/authenticate', function(req, res) {
  usersDal.GetByEmail(req.query.email, req.query.password, function (err, account) {
    var response = {};
    if (err) {
      response.message = err.message;
    }
    else if (account == null) {
      response.message = 'Account not found.';
    }
    else {
      req.session.account = account;
      console.log(account);
      res.send(account);
    }
  });
});

module.exports = router;
