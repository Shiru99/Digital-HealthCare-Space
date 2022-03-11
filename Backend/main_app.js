var express = require('express');
var app = express();
var router = require('./routes/route');
var my_config = require('./config');
var bodyParser = require('body-parser')
var my_sql = require('./services/my_sql')


app.use(bodyParser.urlencoded({ extended: false }))
// parse application/json
app.use(bodyParser.json())


var server = app.listen(my_config.PORT, function () {
    console.log('listening on port ' + my_config.PORT);
})      // default 9000

// app.get('/exit', function (req, res) {
//     exit(0)
// })

my_sql.connect();
app.use(router)
