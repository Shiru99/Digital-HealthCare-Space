const { Response } = require('http-status-codez');
var my_sql = require('../services/my_sql')


create = function (req, res) {
    console.log(req.params, req.body)
    var status = Response.HTTP_OK

    var response = {}
    var query = "INSERT INTO doctors (name, contact, email, password, experience, age) VALUES('" + 
                req.body.name + "', '" + req.body.contact + "', '" + req.body.email + "', " + 
                req.body.password + "', '" + req.body.experience + "', "+ req.body.age;
    my_sql.query(query, function (err,results) {
        if (err) {
            status = Response.HTTP_NOT_FOUND
            response.status = err
            console.log(err)
        }
        else if (result.affectedRows > 0) {
            response.status = "request success."
            response.userId = results[0].id
        }
        else
        {
            status = Response.HTTP_NOT_FOUND
            response.status = result
            console.log(response)
        }
    })

    res.status(status).send(response);
}

deleteReq = function (req, res) {
    var status = Response.HTTP_NOT_FOUND

    res.status(status).send("Implementaion pending");
}

module.exports = {
    create,
    deleteReq,
}
