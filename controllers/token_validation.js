const jwt = require('jsonwebtoken');

function checkAuth(req, res, next) {
    const token = req.cookies['x-auth-token'];
    if(token) {
        jwt.verify(token, process.env.JWT_PRIVATEKEY, (err, decoded) => {
            if(err) {
                res.json({
                    success: 0,
                    message: "Invalid Token"
                });
            } else {
                req.user = decoded;
                next();
            }
        });
    } else {
        res.json({
            success: 0,
            message: "Sorry! You are not logged in!"
        });
    }
}


module.exports = checkAuth;