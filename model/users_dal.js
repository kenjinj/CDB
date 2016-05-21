var mysql   = require('mysql');
var db  = require('./db_connection.js');

/* DATABASE CONFIGURATION */
var connection = mysql.createConnection(db.config);

exports.GetAll = function(callback) {
    connection.query('SELECT * FROM cdb_users;',
        function (err, result) {
            if(err) {
                console.log(err);
                callback(true);
                return;
            }
            console.log(result);
            callback(false, result);
        }
    );
}

exports.AddLoad = function(account_info, load_info, callback) {
    var dynamic_query = 'INSERT INTO cdb_userSavedLoads (user_id, load_id) VALUES (' +
        '\'' + account_info.user_id + '\', ' +
        '\'' + load_info.load_id + '\'' +
        ');';
    console.log(dynamic_query);

    // connection.query(query, is where the SQL string we built above is actually sent to the MySQL server to be run
    connection.query(dynamic_query,
        function (err, result) {

            // if the err parameter isn't null or 0, then it will run the code within the if statement
            if(err) {
                console.log(err);
                callback(true);
                return;
            }
            callback(false, result);
        }
    );
}

exports.DeleteLoad = function(account_info, load_info, callback) {
    var dynamic_query = 'DELETE FROM cdb_userSavedLoads WHERE user_id = ' +
        '\'' + account_info.user_id + '\' and load_id = ' +
        '\'' + load_info.load_id + '\'' +
        ';';
    console.log(dynamic_query);

    // connection.query(query, is where the SQL string we built above is actually sent to the MySQL server to be run
    connection.query(dynamic_query,
        function (err, result) {

            // if the err parameter isn't null or 0, then it will run the code within the if statement
            if(err) {
                console.log(err);
                callback(true);
                return;
            }
            callback(false, result);
        }
    );
}

exports.Insert = function(account_info, callback) {
    console.log(account_info);
    var dynamic_query = 'INSERT INTO cdb_users (firstname, lastname, email, password) VALUES (' +
        '\'' + account_info.firstname + '\', ' +
        '\'' + account_info.lastname + '\', ' +
        '\'' + account_info.email + '\', ' +
        '\'' + account_info.password + '\'' +
        ');';
    console.log(dynamic_query);

    // connection.query(query, is where the SQL string we built above is actually sent to the MySQL server to be run
    connection.query(dynamic_query,
        function (err, result) {

            // if the err parameter isn't null or 0, then it will run the code within the if statement
            if(err) {
                console.log(err);
                callback(true);
                return;
            }
            callback(false, result);
        }
    );
}

exports.Update = function(user_id, firstname, lastname, state_id, callback) {
    console.log(user_id, firstname, lastname, state_id);
    var values = [firstname, lastname, state_id, user_id];

    connection.query('UPDATE cdb_users SET firstname = ?, lastname = ? WHERE user_id = ?', values,
        function(err, result){
            if(err) {
                console.log(this.sql);
                callback(err, null);
            }
        });
    console.log('Success updating userWeb');
}

var Delete = function(user_id, callback) {
//function Delete(user_id, callback) {
    var qry = 'DELETE FROM cdb_users WHERE user_id = ?';
    connection.query(qry, [movie_id],
        function (err) {
            callback(err);
        });
}

exports.GetByEmail = function(email, password, callback) {
    var query = 'CALL cdb_Account_GetByEmail(?, ?)';
    var query_data = [email, password];
    connection.query(query, query_data, function(err, result) {
        if(err){
            callback(err, null);
        }
        else if(result[0].length == 1) {
            callback(err, result[0][0]);
        }
        else {
            callback(err, null);
        }
    });
};

exports.DeleteById = Delete;