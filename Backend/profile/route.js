var express = require('express');
var router = express.Router();

var admin = require('./admin')
var user = require('./user')
var doctor = require('./doctor')

router.get('/user/:userId', user.getProfile)
router.post('/user', user.updateProfile)
router.get('/admin/:adminId', admin.getProfile)
router.post('/admin', admin.updateProfile)
router.get('/doctor/:doctorId', doctor.getProfile)
router.get('/doctor/list', doctor.getDoctorList)
router.post('/doctor', doctor.updateProfile)

module.exports = router
