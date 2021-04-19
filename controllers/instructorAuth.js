function isInstructor (req, res, next) {
    if(req.user.role !== 'instructor') {
        return res.status(403).send('Access denied, You are not authorized!');
    }
    next();
}

module.exports = isInstructor;