const { Response } = require('http-status-codez');


update = function (req, res) {
    console.log(req.params, req.body)
    var status = Response.HTTP_OK
    var response = {}
    var query = "UPDATE users SET "
    var userId = req.body.userId
    delete req.body.userId
    Object.keys(req.body).forEach(function(k){
        query += k + "=" + req.body[k] + " "
    });
    query += " where id=" + userId;
    // console.log(query);
    my_sql.query(query, function (err,results) {
        if (err) {
            console.log(err)
            status = Response.HTTP_NOT_FOUND
            response.status = err
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
    update,
}
