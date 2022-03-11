const { Response } = require('http-status-codez');


getDoctorList = function (req, res) {
    console.log(req.params, req.body)
    var status = Response.HTTP_NOT_FOUND

    res.status(status).send("Implementaion pending");
}

module.exports = {
    getDoctorList,
}
