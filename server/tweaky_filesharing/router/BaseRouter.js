const FileMessageRouter = require('./file_message/FileMessageRouter')
const RoomRouter = require('./room/RoomRouter')
const BaseRouter = require('express').Router()



// Routes
BaseRouter.use('/room', RoomRouter)
BaseRouter.use('/room/', FileMessageRouter)


module.exports = BaseRouter