const { Schema, model } = require('mongoose')


const ChatRoomSchema = new Schema({
    name: {
        type: String,
        maxlength: 30,
        unique: true,
    },
});

module.exports = model('chat_room', ChatRoomSchema)