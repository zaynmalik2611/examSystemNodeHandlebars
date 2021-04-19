const express = require('express');
const mysql = require('mysql');
const router = express.Router();
const checkAuth = require('../controllers/token_validation');
const isInstructor = require('../controllers/instructorAuth');

const conn = mysql.createConnection({
    host: process.env.HOST,
    user: process.env.USER,
    password: process.env.PASSWORD,
    database: process.env.DATABASE,
    port: process.env.PORT_DB
});

router.get('/', [checkAuth, isInstructor], async (req, res) => {
    res.render('instructor.hbs',{
        name: req.user.name
    });
});

router.get('/courses', [ checkAuth, isInstructor ], (req, res) => {
    conn.query('SELECT courseMeta, courseName FROM courses WHERE instructor = ?', [ req.user.name ], async (err, results) => {
        if(err) throw err; 
        res.render('courses.hbs', {
            courses: results
        });
    });
    
});

router.get('/courses/:meta', [ checkAuth, isInstructor ], (req, res) => {
    var sql = "SELECT courseMeta, courseName FROM courses WHERE courseMeta = ?";
    conn.query(sql, [ req.params.meta ], async ( err, results ) => {
        if (err) throw err;
        course = results;
        var sql = "SELECT examName, examID FROM exams WHERE courseMeta = ?";
        conn.query(sql, [ req.params.meta ], async ( err, results) => {
            if (err) throw err;
            res.render('instructorExamList.hbs', {
                courseMeta: course[0].courseMeta,
                courseName: course[0].courseName,
                examInfo: results
            });
        });
    });
});

router.get('/courses/:meta/createExam', [ checkAuth, isInstructor ], (req, res) => {
    conn.query('SELECT courseMeta, courseName FROM courses WHERE courseMeta = ?', [req.params.meta], async (err, results) => {
        if (err) throw err;
        res.render('createExam.hbs', {
            course: results
        });
    });
});


router.post('/courses/createExam', [ checkAuth, isInstructor ], (req, res) => {
    const { eName, eDate, eTime, duration, qN1, q1, a1, qN2, q2, a2, courseMeta } = req.body;
    conn.query('INSERT INTO exams SET ?', {examName: eName, dat: eDate, tim: eTime, duration: duration, courseMeta: courseMeta}, async ( err, results ) => {
        if (err) throw err;
        console.log(results);
        var sql = 'INSERT INTO questions (examID, questionNum, question) VALUES ?';
        var values = [
            [results.insertId, qN1, q1],
            [results.insertId, qN2, q2]
        ];
        conn.query(sql, [values], async ( err, results ) => {
            if (err) throw err;
            console.log(results);
            var sql = 'INSERT INTO answers (questionID, answerNum, answer) VALUES ?';
            var values = [
                [results.insertId, 1,  a1],
                [results.insertId + 1, 2, a2]
            ];
            conn.query(sql, [values], async( err, results ) => {
                if (err) throw err;
                console.log(results);
            });
        });
    });
    res.render('view.hbs', {
        name: eName,
        date: eDate,
        time: eTime,
        duration: duration,
        n1: qN1,
        q1: q1,
        a1: a1,
        n2: qN2,
        q2: q2,
        a2: a2
    });
});

router.delete('/deleteExam/:id', [checkAuth, isInstructor], ( req, res ) => {
    var sql = "SELECT examName FROM exams WHERE examID = ?";
    conn.query(sql, [req.params.id], async (err, results) => {
        if (err) throw err;
        if (results.length > 0) {
            var sql = "DELETE FROM questions WHERE examID = ?";
            conn.query(sql, [req.params.id], async (err, results) => {
                if (err) throw err;
                conn.query("DELETE FROM exams WHERE examID = ?", [ req.params.id ], async (err, results) => {
                    if (err) throw err;
                    res.json({
                        message: "The exam you requested is deleted. Please refresh the page",
                        redirect: "/"
                    });
                });
                
            });
        } else {
            res.json({
                message: "That exam doesn't exist",
                redirect: "/"
            });
        }
    });
});

router.post('/success', [ checkAuth, isInstructor], (req, res) => {
    const { examName } = req.body;
    res.render('success.hbs', {
        name: examName
    });
});



module.exports = router;