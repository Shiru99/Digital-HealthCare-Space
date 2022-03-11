const { Response } = require('http-status-codez');
var my_sql = require('../services/my_sql')


getProfile = function (req, res) {
    console.log(req.params, req.body)
    var status = Response.HTTP_OK
    var response = {}
    var query = "SELECT name, contact, email, econtact, age FROM users where id='" + req.params.userId + "'";
    my_sql.query(query, function (err,results) {
        if (err) {
            status = Response.HTTP_NOT_FOUND
            response.status = err
        }
        else if (results.length > 0) {
            response = results[0]
            response.userId = req.params.userId
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
    var status = Response.HTTP_OK
    var response = {}
    var query = "UPDATE users SET name='" + req.body.name + "', contact='" + req.body.contact +
                "', email='" + req.body.email + "', sex='" + req.body.sex + "', password='" +
                req.body.password + "', econtact='" + req.body.econtact + "', age="+ req.body.age +
                "where id=" + req.body.userId;
    my_sql.query(query, function (err,results) {
        if (err) {
            status = Response.HTTP_NOT_FOUND
            response.status = err
            console.log(err)
        }
        else if (result.affectedRows > 0) {
            response.status = "request success."
        }
        else
        {
            status = Response.HTTP_NOT_FOUND
            response.status = result
            console.log(response)
        }

        res.status(status).send(response);
    })
}

module.exports = {
    getProfile,
    updateProfile,
}
