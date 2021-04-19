const express = require('express');
const router = express.Router();
const mysql = require('mysql');

const conn = mysql.createConnection({
    host: process.env.HOST,
    user: process.env.USER,
    password: process.env.PASSWORD,
    database: process.env.DATABASE,
    port: process.env.PORT_DB
});

router.get('/', (req, res) => {
    res.render('home.hbs');
});
router.get('/test', (req, res) => {
    res.render('createTest');
});
router.post('/test', (req, res) => {
    console.log(req.body);
    res.send('Form sent successfully!');
});
router.get('/deleteStuff', (req, res) => {
    conn.query('SELECT * FROM stuff', async (err, results) => {
        if (err) throw err;
        res.render('deleteList.hbs', {
            stuff: results
        });
    });
    
})
router.delete('/deleteStuff/:id', (req, res) => {
    var sql = "SELECT maal FROM stuff WHERE id = ?";
    conn.query(sql, [req.params.id], async (err, results) => {
        if (err) throw err;
        if(results.length != 0) {
            var sql = "DELETE FROM stuff WHERE id = ?";
            conn.query(sql, [req.params.id], async (err, results) => {
                if (err) throw err;
                res.json({
                    message: "The maal you requested is deleted",
                    redirect: '/deleteStuff'
                });
            });
        } else {
            res.json({
                message: "The requested id doesn't exist.",
                redirect:  '/deleteStuff'
            });
        }
    });  
});
module.exports = router;