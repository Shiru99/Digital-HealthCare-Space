const { Response } = require('http-status-codez');
var my_sql = require('../services/my_sql')


getProfile = function (req, res) {
    console.log(req.params, req.body)
    var status = Response.HTTP_OK
    var response = {}
    var query = "SELECT name, contact, email, experience, age FROM doctors where id='" + req.params.doctorId + "'";
    my_sql.query(query, function (err,results) {
        if (err) {
            status = Response.HTTP_NOT_FOUND
            response.status = err
            console.log(err)
        }
        else if (results.length > 0) {
            response = results[0]
            response.doctorId = req.params.doctorId
            response.status = "request success."
        }
        else
        {
            status = Response.HTTP_NOT_FOUND
            response.status = "No User with given UserId found."
            console.log(response)
        }

        res.status(status).send(response);
    })
}

getDoctorList = function (req, res) {
    console.log(req.params, req.body)
    var status = Response.HTTP_OK
    var response = {}
    var query = "SELECT id as doctorId, name, contact, email, experience, age FROM doctors";
    my_sql.query(query, function (err,results) {
        if (err) {
            status = Response.HTTP_NOT_FOUND
            response.status = err
        }
        else if (results.length > 0) {
            response.doctorInfo = results
            response.status = "request success."
        }
        else
        {
            status = Response.HTTP_NOT_FOUND
            response.status = "No User with given UserId found."
        }

        res.status(status).send(response);
    })
}

updateProfile = function (req, res) {
    console.log(req.params, req.body)
    var status = Response.HTTP_NOT_FOUND

    res.status(status).send("Implementaion pending");
}

module.exports = {
    getProfile,
    updateProfile,
    getDoctorList,
}
