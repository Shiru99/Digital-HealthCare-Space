const { Response } = require('http-status-codez');
var my_sql = require('../services/my_sql')


create = function (req, res) {
    console.log(req.params, req.body)
    var status = Response.HTTP_NOT_FOUND

    res.status(status).send("Implementaion pending");
}

deleteReq = function (req, res) {
    var status = Response.HTTP_NOT_FOUND

    res.status(status).send("Implementaion pending");
}

module.exports = {
    create,
    deleteReq,
}
