var express = require('express');
var router = express.Router();

var status = require('./status')
var update = require('./update')

router.get('/status/:userId', status.getStatus)
router.post('/update', update.update)

module.exports = router
