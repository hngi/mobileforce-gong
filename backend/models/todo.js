const mongoose = require('mongoose')

const TodoSchema = mongoose.Schema({
    title: String,
    userID: String,
    time: String,
    completed: Boolean,
    date: String
}, {
    timestamps: true
});

module.exports = mongoose.model('Reminder', TodoSchema);
