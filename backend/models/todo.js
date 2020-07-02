const mongoose = require('mongoose')

const TodoSchema = mongoose.Schema({
    title: String,
    content: String,
    userID: String,
    time: String,
    completed: Boolean,
    date: String,
    category: String
}, {
    timestamps: true
});

module.exports = mongoose.model('Reminder', TodoSchema);
