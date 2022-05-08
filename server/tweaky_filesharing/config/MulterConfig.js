const multer = require('multer')
const path = require('path')

const fileMessageStorage = multer.diskStorage({
    destination: (req, res, callback) => {
        callback(null, './public/user-files');
    },
    filename: function (req, file, cb) {
        const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9)
        cb(null, file.fieldname + '-' + uniqueSuffix + path.extname(file.originalname))
    }
})

module.exports = {
    fileMessageUpload: multer({ storage: fileMessageStorage }).single('file_message')
}