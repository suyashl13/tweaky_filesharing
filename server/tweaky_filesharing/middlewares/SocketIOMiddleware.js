module.exports = (app, io) => {
    app.use((req, res, next) => {
        req.io = io
        next();
    })
}