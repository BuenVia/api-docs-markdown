const express = require('express')
const bodyParser = require('body-parser')
const pg = require('pg')

// Set app details
const app = express()
let port = 8000

// Set DB details
const db = new pg.Client({
    user: 'postgres',
    host: 'localhost',
    database: 'api_docs',
    password: 'Guitara_11',
    port: 5432
})
db.connect()

// Middleware
app.set('view engine', 'ejs')
app.use(bodyParser.urlencoded({ extended: true }))
app.use(express.static(`${__dirname}/public`))
app.use(express.json())

// DB Helper Functions
async function getCategories () {
    const results = await db.query('SELECT * FROM call_categories')
    return results.rows
}

const getCalls = async () => {
    const results = await db.query('SELECT * FROM calls JOIN call_categories ON calls.id = category_id')
    return results.rows;
}

// Routing
app.get('/', async (req, res) => {
    const calls = await getCalls()
    const categories = await getCategories()
    res.render('index', { categories: categories, calls: calls })
})



app.listen(port, () => {
    console.log(`App is listening on port: ${port}`);
})