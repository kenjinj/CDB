var express = require('express');
var router = express.Router();
var cartridgeDal = require('../model/cartridge_dal');

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

module.exports = router;
