const ChatRoomModel = require('../../models/ChatRoomModel');
const FileMessageModel = require('../../models/FileMessageModel');

const RoomRouter = require('express').Router()

RoomRouter.post('/', async (req, res, next) => {
    const { name } = req.body;
    let newRoom = new ChatRoomModel({ name })
    try {
        newRoom = await newRoom.save()
    } catch (error) {
        if (error.code === 11000) {
            return res
                .status(401)
                .json({
                    success: false,
                    error: "Room with same name already exist. Please try using another name."
                });
        } else {
            return res
                .status(400)
                .json({
                    success: false,
                    error: "Something went wrong."
                });
        }
    }
    return res.json(newRoom)
})

RoomRouter.get('/:room', async (req, res, next) => {
    try {

        return res.json((await FileMessageModel.find({ room: (await ChatRoomModel.findOne({name: req.params.room}))._id })))
    } catch (error) {
        console.log(error)
        return res.status(401)
            .json({
                success: false,
                error: "Something went wrong."
            });
    }
})

module.exports = RoomRouter