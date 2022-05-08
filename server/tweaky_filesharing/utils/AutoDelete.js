const fs = require('fs')
const FileMessageModel = require('../models/FileMessageModel')

function expireAndDeleteMsg() {
    FileMessageModel.find().then((fileMessage) => {
        fileMessage.forEach((msg, index) => {
            if (!msg.is_expired) {
                const timeNow = Date.now()
                const fileUploadDate = new Date(msg.createdAt).getTime();

                if ((timeNow - fileUploadDate) > (120 * 1000)) {
                    fs.unlink(`./public/${msg.display_url}`, (err) => {
                        if (err) {
                            console.log(err)
                            console.log("Unable to delete file : " + msg.file_path)
                        } else {
                            console.log('Deleted : ' + msg.file_path);
                        }
                        FileMessageModel.updateOne({ _id: msg._id }, {
                            is_expired: true,
                            status: 'Expired',
                            file_path: '',
                        }).then(e => { })
                    })
                }
            }
        })
    }).catch(err => { console.log(err) })
}

module.exports = expireAndDeleteMsg