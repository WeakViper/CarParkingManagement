require('dotenv').config()
const bodyParser = require('body-parser');
const cors = require('cors');


const express = require('express'); 

//const userRouter = require('./routes/user');

const app = express();
app.use(cors());
app.use(bodyParser.json());

app.use(express.json());
//app.use('/user', userRouter);


app.listen(3500, function() {
    console.log('Listening on http://localhost:3500');
});