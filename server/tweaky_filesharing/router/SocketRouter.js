const FileMessageModel = require("../models/FileMessageModel")

module.exports = (io) => {

    io.on('connection', function async(client) {
        let { roomName } = client.handshake.query
        console.log("Connected :- " + client.id)
        console.log("Room :- " + roomName);
        client.join(roomName)
    })
}