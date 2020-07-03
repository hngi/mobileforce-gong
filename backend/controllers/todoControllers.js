const Todo = require('../models/todo.js');

// Create and Save a new Todo
exports.create = (req, res) => {
    // Validate request
    if (!req.body.title) {
        return res.status(400).send({
            message: "Todo title can not be empty"
        });
    }

    // Create a Todo
    const todo = new Todo({
        title: req.body.title,
        content: req.body.content,
        userID: req.body.userID,
        category: req.body.category,
        time: req.body.time,
        completed: req.body.completed,
        date: req.body.date
    });

    // Save todo in the database
    todo.save()
        .then(data => {
            res.status(200).send(data);
        }).catch(err => {
            res.status(500).send({
                message: err.message || "Some error occurred while creating the todo."
            });
        });
};


// Retrieve and return all reminders from the database.
exports.findAll = (req, res) => {
    var query = {userID : req.body.userId}
    Todo.find(query, {createdAt: 0, updatedAt: 0, __v: 0}).sort('-createdAt')
        .then(reminders => {
            res.send(reminders);
        }).catch(err => {
            res.status(500).send({
                message: err.message || "Some error occurred while retrieving reminders."
            });
        });
};


exports.findImportant = (req, res) => {
    var query = {userID: req.body.userId, important: true};
    Todo.find(query, {createdAt: 0, updatedAt: 0, __v: 0}).sort('-createdAt')
        .then(reminders => {
            res.send(reminders);
        }).catch(err => {
            res.status(500).send({
                message: err.message || "Some error occurred while retrieving reminders."
            });
        });
};

// Find a single todo with a reminderId
exports.findOne = (req, res) => {
    Todo.findById(req.params.reminderId, {createdAt: 0, updatedAt: 0, __v: 0})
        .then(todo => {
            if (!todo) {
                return res.status(404).send({
                    message: "todo not found with id " + req.params.reminderId
                });
            }
            res.send(todo);
        }).catch(err => {
            if (err.kind === 'ObjectId') {
                return res.status(404).send({
                    message: "todo not found with id " + req.params.reminderId
                });
            }
            return res.status(500).send({
                message: "Error retrieving todo with id " + req.params.reminderId
            });
        });
};

exports.findOneByUser = (req, res) => {
    Todo.findById(req.params.userId, {createdAt: 0, updatedAt: 0, __v: 0}).sort('-createdAt')
        .then(todo => {
            if (!todo) {
                return res.status(404).send({
                    message: "todo not found with id " + req.params.userId
                });
            }
            res.send(todo);
        }).catch(err => {
            if (err.kind === 'ObjectId') {
                return res.status(404).send({
                    message: "todo not found with id " + req.params.userId
                });
            }
            return res.status(500).send({
                message: "Error retrieving todo with id " + req.params.userId
            });
        });
};

// Update a todo identified by the reminderId in the request
exports.update = (req, res) => {
    // Validate Request
    if (!req.body.title && !req.body.content) {
        return res.status(400).send({
            message: "todo title can not be empty"
        });
    }
    //The {new: true} option in the findByIdAndUpdate() method is used to return the modified document to the then() function instead of the original
    // Find todo and update it with the request body
    Todo.findByIdAndUpdate(req.params.reminderId, {
        title: req.body.title,
        content: req.body.content,
        category: req.body.category,
        date: req.body.date,
        time: req.body.time
    }, { new: true })
        .then(todo => {
            if (!todo) {
                return res.status(404).send({
                    message: "todo not found with id " + req.params.reminderId
                });
            }
            res.send(todo);
        }).catch(err => {
            if (err.kind === 'ObjectId') {
                return res.status(404).send({
                    message: "todo not found with id " + req.params.reminderId
                });
            }
            return res.status(500).send({
                message: "Error updating todo with id " + req.params.reminderId
            });
        });
};

// Delete a todo with the specified reminderId in the request
exports.delete = (req, res) => {
    Todo.findByIdAndRemove(req.params.reminderId)
        .then(todo => {
            if (!todo) {
                return res.status(404).send({
                    message: "todo not found with id " + req.params.reminderId
                });
            }
            res.send({ message: "todo deleted successfully!" });
        }).catch(err => {
            if (err.kind === 'ObjectId' || err.name === 'NotFound') {
                return res.status(404).send({
                    message: "todo not found with id " + req.params.reminderId
                });
            }
            return res.status(500).send({
                message: "Could not delete Todo with id " + req.params.reminderId
            });
        });
};
