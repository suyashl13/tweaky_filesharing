const express = require('express')
const mongoose = require('mongoose')
const morgan = require('morgan')
const { Server } = require("socket.io");

const CustomErrorHandler = require('./middlewares/CustomErrorHandler')
const SocketIOMiddleware = require('./middlewares/SocketIOMiddleware')
const BaseRouter = require('./router/BaseRouter');
const SocketRouter = require('./router/SocketRouter');
const expireAndDeleteMsg = require('./utils/AutoDelete');
const app = express()

require('dotenv').config()

// Database
mongoose.connect(process.env.MONGO_URI, {})
    .then(() => { console.log("Connected to Database!") })
    .catch((err) => { console.error("Could not connect to Database : " + err.message) })


// Listen
const server = app.listen(process.env.PORT, () => { console.log("Listening on port : " + process.env.PORT) })
const io = new Server(server, { cors: { origin: '*' } });


// Middlewares
app.use(express.json())
app.use(express.static('public'))
app.use(express.urlencoded({ extended: false }))
app.use(CustomErrorHandler)
app.use(morgan(':method :url :status :res[content-length] - :response-time ms'))
SocketIOMiddleware(app, io)
SocketRouter(io)
setInterval(expireAndDeleteMsg, 15000);


// Router
app.use('/api/v1', BaseRouter)