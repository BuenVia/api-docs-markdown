const express = require('express')

const app = express()

let port = 8000

app.get('/', (req, res) => {
    res.send('Hello world!')
})



app.listen(port, () => {
    console.log(`App is listening on port: ${port}`);
})