const { Response } = require('http-status-codez');
var my_sql = require('../services/my_sql')


getProfile = function (req, res) {
    console.log(req.params, req.body)
    var status = Response.HTTP_OK
    var response = {}
    var query = "SELECT name, contact, email FROM admin where id='" + req.params.adminId + "'";
    my_sql.query(query, function (err,results) {
        if (err) {
            console.log(err)
            status = Response.HTTP_NOT_FOUND
            response.status = err
        }
        else if (results.length > 0) {
            response = results[0]
            response.adminId = req.params.adminId
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

updateProfile = function (req, res) {
    console.log(req.params, req.body)
    var status = Response.HTTP_NOT_FOUND

    res.status(status).send("Implementaion pending");
}

module.exports = {
    getProfile,
    updateProfile,
}
