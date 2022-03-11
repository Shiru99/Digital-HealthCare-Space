var express = require('express');
var router = express.Router();


var user = require('./user')
var doctor = require('./doctor')

router.get('/user/list', user.user_list)
router.get('/doctor/list', doctor.doctor_list)


module.exports = router
