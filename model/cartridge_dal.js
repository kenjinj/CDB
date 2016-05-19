var mysql   = require('mysql');
var db  = require('./db_connection.js');

/* DATABASE CONFIGURATION */
var connection = mysql.createConnection(db.config);

exports.GetAllSearchOptions = function(callback) {
    connection.query('SELECT * FROM cdbView_all;',
        function (err, result) {
            if(err) {
                console.log(err);
                callback(true);
                return;
            }
            callback(false, result);
        }
    );
}

exports.GetAllPowders = function(callback) {
    connection.query('SELECT pow.powder_id, name FROM cdb_powder pow JOIN cdb_load l ON l.powder_id = pow.powder_id GROUP BY pow.powder_id ORDER BY powder_id ASC;',
        function (err, result) {
            if(err) {
                console.log(err);
                callback(true);
                return;
            }
            callback(false, result);
        }
    );
}

exports.GetFromOptions = function(case_id, proj_id, powder_id, callback) {
    var query = "CALL cdb_CartridgeSearch(?, ?, ?)";
    var query_data = [case_id, proj_id, powder_id];
    connection.query(query, query_data, function(err, result) {
        if(err){
            callback(err, null);
        }
        else if(result[0].length > 0) {
            callback(err, result[0]);
        }
        else {
            callback(err, null);
        }
    });
}
