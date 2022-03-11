var express = require('express');
var router = express.Router();


var admin_route = require('../admin/route')
var health_route = require('../health/route')
var link_route = require('../link/route')
var login_route = require('../login/route')
var profile_route = require('../profile/route')
var register_route = require('../register/route')

router.use('/admin/', admin_route)
router.use('/health/', health_route)
router.use('/link/', link_route)
router.use('/login/', login_route)
router.use('/profile/', profile_route)
router.use('/register/', register_route)


module.exports = router
