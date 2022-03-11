const http = require('http');
var config = require('../config')

var options = {
    host: config.AI_REST_URL,
    port: config.AI_REST_PORT,
    path: config.AI_REST_PATH,
    method: config.AI_REST_METHOD,
    headers: {
        'Content-Type': 'application/json',
    }
};

function getStatus(req, callback) {

    const postData = JSON.stringify(req)
    options.headers('Content-Length') = Buffer.byteLength(postData)

    const request = http.request(options, function(res) {
        data = ""
        console.log('STATUS: ' + res.statusCode);
        console.log('HEADERS: ' + JSON.stringify(res.headers));
        res.setEncoding('utf8');
        res.on('data', function (chunk) {
            console.log('BODY: ' + chunk);
        });
        res.on('end', () => {
            console.log('No more data in response.');
            if(data == "") {
                callback("No Data Found", null);
            }
            else {
                callback(null, data)
            }
        });
    })
    req.on('error', (e) => {
        console.error(`problem with request: ${e.message}`);
        callback(e,message, null)
    });

    // Write data to request body
    req.write(postData);
    req.end();
}

module.exports = {
    getStatus,
}
