var express = require('express');
var router = express.Router();


var admin = require('./admin')
var user = require('./user')
var doctor = require('./doctor')

router.get('/user/:userId', user.getUser)
router.get('/user/:userReqList', user.getUserList)
router.post('/user', user.linkUser)
router.get('/doctor/list', doctor.getDoctorList)
router.post('/doctor', user.linkDoctor)
router.post('/admin', admin.link)

module.exports = router
