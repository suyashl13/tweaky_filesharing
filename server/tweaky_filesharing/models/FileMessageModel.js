const { Schema, model } = require('mongoose')

const FileMessageSchema = new Schema({
    title: {
        type: String,
        maxlength: 10,
        required: true
    },
    description: {
        type: String,
        maxlength: 50,
    },
    display_url: {
        type: String,
        required: true
    },
    room: {
        type: Schema.Types.ObjectId,
        ref: 'chat_room',
        required: true
    },
    is_expired: {
        type: Boolean,
        default: false,
    }
}, { timestamps: true })

module.exports = model('file_message', FileMessageSchema)