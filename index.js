const express = require('express');
const cookieParser = require('cookie-parser');
const hbs = require('hbs');
const mysql = require('mysql');
const dotenv = require('dotenv');
const bodyParser = require('body-parser');
const path = require('path');
const login = require('./routes/login');
const home = require('./routes/home');
const register = require('./routes/register');
const student = require('./routes/student');
const instructor = require('./routes/instructor');

dotenv.config();

const conn = mysql.createConnection({
    host: process.env.HOST,
    user: process.env.USER,
    password: process.env.PASSWORD,
    database: process.env.DATABASE,
    port: process.env.PORT_DB
});

conn.connect((err) => {
    if(err) {
        console.log(err.message);
    }
    console.log('db '+conn.state);
});

const app = express();


app.set('view engine', 'hbs');
app.set('views', './views');

app.use(express.static('./public'));
app.use(bodyParser.urlencoded({extended: false}));
app.use(cookieParser());
app.use(express.json());
app.use('/login', login);
app.use('/register', register);
app.use('/student', student);
app.use('/instructor', instructor);
app.use('/', home);


hbs.registerHelper('test', function(context, options) {
    console.log(context);
    return options.fn(context);
});

const port = process.env.PORT || 3000;

app.listen(port, () => {
    console.log(`Listening on port ${port}...`);
});