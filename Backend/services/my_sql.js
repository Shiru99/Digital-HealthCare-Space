var mysql = require('mysql');
var config = require('../config');

var con = mysql.createConnection({
    host: config.MYSQL_REST_URL,
    user: config.MYSQL_REST_USER,
    password: config.MYSQL_REST_PASS,
    database: config.MYSQL_DB
});

function connect() {
    con.connect(function(err) {
        if (err) throw err;
        console.log("Connected!");
    });
}

function query(query, callback) {
    con.query(query, callback)
}

module.exports = {
    connect,
    query
}
