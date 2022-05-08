const FileMessageRouter = require('express').Router()
const { fileMessageUpload } = require('../../config/MulterConfig')
const ChatRoomModel = require('../../models/ChatRoomModel')
const FileMessageModel = require('../../models/FileMessageModel')


FileMessageRouter.post('/:room_name/file-message', (req, res, next) => {
    fileMessageUpload(req, res, async (err) => {
        const {
            title,
            description,
        } = req.body
        try {
            console.log(req.params)
            let fileMessage = new FileMessageModel({
                room: (await ChatRoomModel.findOne({ name: req.params.room_name }))._id,
                title: title,
                description: description ? description : 'None',
                display_url: `user-files/${req.file.filename}`
            })
            fileMessage = await fileMessage.save()
            req.io.on('connection', (socket) => {
                socket.on('file_message', (e) => {
                    e.emit(fileMessage)
                })
            })
            req.io.to(req.params.room_name).emit('file_message', fileMessage)
            res.json({ success: true, fileMessage })
        } catch (error) {
            console.log(error)
            res.status(400).json({ success: false, err: 'Something went wrong!' })
        }
    })
})

module.exports = FileMessageRouter