const { Response } = require('http-status-codez');
var my_sql = require('../services/my_sql')


login = function (req, res) {
    console.log(req.params, req.body)
    var status = Response.HTTP_OK
    var response = {}
    var query = "SELECT id FROM admin where 'contact'='" + req.body.contact + "' AND password='" + req.body.password + "'";
    my_sql.query(query, function (err,results) {
        if (err) {
            status = Response.HTTP_NOT_FOUND
            response.status = err
            console.log(err)
        }
        else if (results.length > 0) {
            response.status = "request success."
            response.adminId = results[0].id
        }
        else
        {
            status = Response.HTTP_NOT_FOUND
            response.status = "No Admin with given Contact or Password combination found."
            console.log(response)
        }

        res.status(status).send(response);
    })
}

module.exports = {
    login,
}
