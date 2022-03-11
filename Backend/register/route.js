var express = require('express');
var router = express.Router();


var admin = require('./admin')
var user = require('./user')
var doctor = require('./doctor')

router.post('/admin', admin.create)
router.post('/doctor', doctor.create)
router.post('/user', user.create)
router.delete('/admin', admin.deleteReq)
router.delete('/doctor', doctor.deleteReq)
router.delete('/user', user.deleteReq)

module.exports = router
