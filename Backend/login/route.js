var express = require('express');
var router = express.Router();

var admin = require('./admin')
var user = require('./user')
var doctor = require('./doctor')

router.post('/admin', admin.login)
router.post('/doctor', doctor.login)
router.post('/user', user.login)

module.exports = router
