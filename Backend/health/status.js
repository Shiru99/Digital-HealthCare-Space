const { Response } = require('http-status-codez');
var ai = require('../ai/update')

getStatus = function (req, res) {
    console.log(req.params, req.body)
    var status = Response.HTTP_OK
    var response = {}
    var query = "SELECT name, contact, email, econtact, age FROM users where id='" + req.params.userId + "'";
    my_sql.query(query, function (err,results) {
        if (err) {
            status = Response.HTTP_NOT_FOUND
            response.status = err

            console.log(err)
            res.status(status).send(response);
        }
        else if (results.length > 0) {
            response = results[0]
            ai.getStatus(results[0], function(err, status) {
                if (err) {
                    status = Response.HTTP_NOT_FOUND
                    response.status = err
                    console.log(err)
                }
                else {
                    response.status = "request success."
                    response.heartAttackChance = status
                }

                res.status(status).send(response);
            })
        }
        else
        {
            status = Response.HTTP_NOT_FOUND
            response.status = "No User with given UserId found."
            console.log(response)

            res.status(status).send(response);
        }
    })
}

module.exports = {
    getStatus,
}
