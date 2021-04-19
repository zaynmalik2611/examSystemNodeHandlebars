const express = require('express');
const router = express.Router();
var mysql = require('mysql');
const checkAuth = require('../controllers/token_validation');

const conn = mysql.createConnection({
    host: process.env.HOST,
    user: process.env.USER,
    password: process.env.PASSWORD,
    database: process.env.DATABASE,
    port: process.env.PORT_DB
});


router.get('/', checkAuth, async (req, res) => {
    var sql = "SELECT courseMeta, courseName FROM courses WHERE EXISTS (SELECT courseMeta FROM students WHERE student_name = ?)";
    conn.query(sql, [req.user.name], async ( err, results ) => {
        if (err) throw err;
        res.render('student.hbs', {
            name: req.user.name,
            courses: results
        });
    });
    
});

router.get('/:meta', checkAuth, (req, res) => {
    var sql = "SELECT courseMeta, courseName FROM courses WHERE courseMeta = ?";
    conn.query(sql, [ req.params.meta ], async ( err, results ) => {
        if (err) throw err;
        course = results;
        var sql = "SELECT examName FROM exams WHERE courseMeta = ?";
        conn.query(sql, [ req.params.meta ], async ( err, results) => {
            if (err) throw err;
            res.render('testList.hbs', {
                courseMeta: course[0].courseMeta,
                courseName: course[0].courseName,
                exams: results
            });
        });
    });
});

router.get('/:meta/:quiz', checkAuth, (req, res) => {
    var sql = "SELECT courseMeta, courseName FROM courses WHERE courseMeta = ?";
    conn.query(sql, [req.params.meta], async (err, results) => {
        if (err) throw err;
        course = results;
        var sql = "SELECT examName, dat, tim, duration FROM exams WHERE examName = ?";
        conn.query(sql, [req.params.quiz], async (err, results) => {
            if (err) throw err;
            var stringedInfo = JSON.stringify(results);
            res.render('startQuiz.hbs', {
                courseMeta: course[0].courseMeta,
                courseName: course[0].courseName,
                examInfo: results,
                stringedInfo: stringedInfo
            });
        });
    });
});

router.get('/:meta/:quiz/attempt', checkAuth, (req, res) => {
    var sql = "SELECT courseMeta, courseName FROM courses WHERE courseMeta = ?";
    conn.query(sql, [req.params.meta], async (err, results) => {
        if (err) throw err;
        course = results;
        var sql = "SELECT examID, examName, duration, tim FROM exams WHERE examName = ?";
        conn.query(sql, [req.params.quiz], async (err, results) => {
            if (err) throw err;
            const examID = results[0].examID;
            const examInfo = results;
            var strDuration = JSON.stringify(examInfo[0].duration);
            var sql = "SELECT a.answer, q.questionNum, q.question FROM questions q JOIN answers a ON q.questionID = a.questionID WHERE examID = ?";
            conn.query(sql, examID, async (err, results) => {
                if (err) throw err;
                const num1 = results[0].questionNum;
                const q1 = results[0].question;
                const ans1 = results[0].answer;
                const num2 = results[1].questionNum;
                const q2 = results[1].question;
                const ans2 = results[1].answer;
                res.render("quiz.hbs", {
                    courseMeta: course[0].courseMeta,
                    courseName: course[0].courseName,
                    examInfo: examInfo,
                    quizData: results,
                    n1: num1,
                    n2: num2,
                    q1: q1,
                    q2: q2,
                    ans1: ans1,
                    ans2: ans2,
                    duration: strDuration
                });
            });
        });
    });
    
});

router.post('/saveExam', [checkAuth], (req, res) => {
    const { a1, a2, ans1, ans2 } = req.body;
    var val = calMarks(a1, ans1, a2, ans2);
    res.render('summary.hbs', {
        name: req.user.name,
        marks: val
    });
});

function calMarks(a1, ans1, a2, ans2) {
    var marks = 0;
    if(a1 === ans1) {
        marks = marks + 5;
    }
    if(a2 ===ans2) {
        marks = marks + 5;
    }
    return marks;
}
module.exports = router;