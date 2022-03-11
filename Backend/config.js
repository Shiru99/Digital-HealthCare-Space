const PORT = 9000

const MYSQL_REST_URL="localhost"
const MYSQL_REST_USER="admin"
const MYSQL_REST_PASS="pass"
const MYSQL_DB="my_db"

const AI_REST_URL="localhost"
const AI_REST_PORT=8080
const AI_REST_PATH="ai/update"
const AI_REST_METHOD="POST"

module.exports = {
    PORT,

    MYSQL_REST_URL,
    MYSQL_REST_USER,
    MYSQL_REST_PASS,
    MYSQL_DB,

    AI_REST_METHOD,
    AI_REST_PATH,
    AI_REST_PORT,
    AI_REST_URL,
}
