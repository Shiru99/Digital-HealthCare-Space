var my_sql = require('../services/my_sql')


function user_list(callback) {
    var query = "SELECT id as userId, name, contact, email, sex, econtact, age FROM users"
    my_sql.query(query, callback)
}

function doctor_list(callback) {
    var query = "SELECT id as doctorId, name, contact, email, experience, age FROM doctors"
    my_sql.query(query, callback)
}


module.exports = {
    user_list,
    doctor_list,
}
