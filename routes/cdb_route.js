var express = require('express');
var router = express.Router();
var cartridgeDal = require('../model/cartridge_dal');
var usersDal = require('../model/users_dal');

/* GET users listing. */
router.get('/', function(req, res, next) {
    res.send('respond with a resource');
});

router.get('/cartridgesAll', function(req, res) {
    cartridgeDal.GetAllSearchOptions(function (err, result) {
        if (err) throw err;
        cartridgeDal.GetAllPowders(function (err, powders) {
            res.render('cartridge_search.ejs', {res: result, powders: powders, message: req.query.message});
        })
    });
});

router.post('/searchResults', function(req, res) {
    cartridgeDal.GetFromOptions(req.body.case_id_list, req.body.proj_id_list, req.body.powder_id_list, function (err, result) {
        res.render('cartridge_search_results.ejs', {res: result});
    });
});

router.get('/saved_loads', function(req, res) {
    cartridgeDal.GetSavedLoads(req.session.account, function(err, result){
        if (err) {
            res.send(err);
        }
        else {
            res.render('userSavedLoads.ejs', {res: result});
        }
    });
});

router.post('/add_load', function(req, res) {
    usersDal.AddLoad(req.session.account, req.body, function(err, result){
        if (err) {
            res.send(err);
        }
        else {
            cartridgeDal.GetSavedLoads(req.session.account, function(err, saved){
                if (err) {
                    res.send(err);
                }
                else {
                    res.render('userSavedLoads.ejs', {res: saved});
                }
            });
        }
    });
});

router.post('/del_load', function(req, res) {
    usersDal.DeleteLoad(req.session.account, req.body, function(err, result){
        if (err) {
            res.send(err);
        }
        else {
            cartridgeDal.GetSavedLoads(req.session.account, function(err, saved){
                if (err) {
                    res.send(err);
                }
                else {
                    res.render('userSavedLoads.ejs', {res: saved});
                }
            });
        }
    });
});


module.exports = router;
