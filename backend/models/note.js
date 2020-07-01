const mongoose = require('mongoose')

const NoteSchema = mongoose.Schema({
    title: String,
    content: String,
    userID: String,
    important: Boolean,
    date: {
        type: Date,
        default: Date.now
    }
}, {
    timestamps: true
});

module.exports = mongoose.model('Note', NoteSchema);
