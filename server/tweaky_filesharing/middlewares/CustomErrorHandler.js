module.exports = ErrorHandler = (error, req, res, next) => {
    if (res.headersSent) {
        return next(err)
    }
    res.status(500)
    res.json({ error: err })
}