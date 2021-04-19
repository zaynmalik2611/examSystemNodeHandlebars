const jwt = require('jsonwebtoken');

const bcrypt = require('bcrypt');
const mysql = require('mysql');
const dotenv = require('dotenv');

dotenv.config();

const conn = mysql.createConnection({
    host: process.env.HOST,
    user: process.env.USER,
    password: process.env.PASSWORD,
    database: process.env.DATABASE,
    port: process.env.PORT_DB
});


exports.register = (req, res) => {
    const { id, username, password, role } = req.body;

    conn.query('SELECT username FROM users WHERE username = ?', [ username ], async (err, results) => {
        if(err) throw err;
        if(results.length > 0) {
            res.send('User already registered.');
        } else {
            const hashedPassword = await bcrypt.hash(password, 8);
            console.log(hashedPassword);
            conn.query('INSERT INTO users SET ?', { username: username, password: hashedPassword, role: role, id: id}, (err, results) => {
                if(err) throw err;
                console.log(results);
                res.send('User Registered!');
            });
        }
        
    });
    
}

exports.login = async (req, res) => {
    try{
        const { username, password } = req.body;
        if(!username || !password) {
            return res.status(400).render('login', {
                message: 'Please provide a username and password!'
            });
        }
        conn.query('SELECT * FROM users WHERE username = ?', [username], async (error, results) => {
            if(results.length === 0 || !(await bcrypt.compare(password, results[0].password))){
                res.status(401).render('login', {
                    message: 'username or password is incorrect'
                });
            } else {
                const {id, role, username} = results[0];
                const token = jwt.sign({ id: id, role: role, name: username}, process.env.JWT_PRIVATEKEY);
                res.cookie('x-auth-token', token);
                if(role === 'instructor') {
                    res.redirect('/instructor');
                } else if(role ==='student') {
                    res.redirect('/student');
                }
            }
        });
    } catch(err) {
        console.log(err);
    }
}