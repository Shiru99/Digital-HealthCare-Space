const { Response } = require('http-status-codez');
var admin_list = require('./list');

doctor_list = function (req, res) {
    var status = Response.HTTP_OK
    var response = {}
    admin_list.doctor_list(function (err,results) {
        if (err) {
            status = Response.HTTP_NOT_FOUND
            response.status = err
            console.log(err)
        }
        else if (results.length > 0) {
            response.status = "request success."
            response.doctorInfo = results
        }
        else
        {
            status = Response.HTTP_NO_CONTENT
            response.status = "request success. but no results found"
            console.log(response)
        }

        res.status(status).send(response);
    })
}

module.exports = {
    doctor_list,
}
