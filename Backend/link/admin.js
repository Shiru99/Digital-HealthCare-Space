const { Response } = require('http-status-codez');


link = function (req, res) {
    var status = Response.HTTP_NOT_FOUND
    console.log(req.params, req.body)

    res.status(status).send("Implementaion pending");
}

module.exports = {
    link,
}
