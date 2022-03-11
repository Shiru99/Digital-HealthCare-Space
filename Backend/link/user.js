const { Response } = require('http-status-codez');


getUser = function (req, res) {
    console.log(req.params, req.body)
    var status = Response.HTTP_NOT_FOUND

    res.status(status).send("Implementaion pending");
}

getUserList = function (req, res) {
    console.log(req.params, req.body)
    var status = Response.HTTP_NOT_FOUND

    res.status(status).send("Implementaion pending");
}

linkUser = function (req, res) {
    console.log(req.params, req.body)
    var status = Response.HTTP_NOT_FOUND

    res.status(status).send("Implementaion pending");
}

linkDoctor = function (req, res) {
    console.log(req.params, req.body)
    var status = Response.HTTP_NOT_FOUND

    res.status(status).send("Implementaion pending");
}

module.exports = {
    getUser,
    getUserList,
    linkUser,
    linkDoctor,
}
