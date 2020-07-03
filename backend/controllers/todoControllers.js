const Todo = require('../models/todo.js');

// Create and Save a new Todo
exports.create = (req, res) => {
    // Validate request
    if (!req.body.title) {
        return res.status(400).send({
            message: "Todo content can not be empty"
        });
    }

    // Create a Todo
    const todo = new Todo({
        title: req.body.title || "Untitled Todo",
        userID: req.body.userID,
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
    Todo.find(query)
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
    Todo.find(query)
        .then(reminders => {
            res.send(reminders);
        }).catch(err => {
            res.status(500).send({
                message: err.message || "Some error occurred while retrieving reminders."
            });
        });
};

// Find a single todo with a todoId
exports.findOne = (req, res) => {
    Todo.findById(req.params.reminderId)
        .then(todo => {
            if (!todo) {
                return res.status(404).send({
                    message: "todo not found with id " + req.params.todoId
                });
            }
            res.send(todo);
        }).catch(err => {
            if (err.kind === 'ObjectId') {
                return res.status(404).send({
                    message: "todo not found with id " + req.params.todoId
                });
            }
            return res.status(500).send({
                message: "Error retrieving todo with id " + req.params.todoId
            });
        });
};

exports.findOneByUser = (req, res) => {
    Todo.findById(req.params.userId)
        .then(todo => {
            if (!todo) {
                return res.status(404).send({
                    message: "todo not found with id " + req.params.userId
                });
            }
            res.send(todo);
        }).catch(err => {
            res.status(500).send({
                message: err.message || "Some error occurred while retrieving notes."
            });
        });
};

// Update a todo identified by the todoId in the request
exports.update = (req, res) => {
    // Validate Request
    if (!req.body.content) {
        return res.status(400).send({
            message: "todo content can not be empty"
        });
    }
    //The {new: true} option in the findByIdAndUpdate() method is used to return the modified document to the then() function instead of the original
    // Find todo and update it with the request body
<<<<<<< HEAD
    Todo.findByIdAndUpdate(req.params.todoId, {
        title: req.body.title,
        content: req.body.content,
        category: req.body.category,
        date: req.body.date,
<<<<<<< HEAD
        time: req.body.time
=======
    Todo.findByIdAndUpdate(req.params.reminderId, {
        title: req.body.title || "Untitled todo",
        content: req.body.content
>>>>>>> 421189ff4a859a6f1f6df17e168e9578fcfb3961
=======
        time: req.body.time,
        completed: req.body.completed
>>>>>>> 7425f1b5fb4a689b577f7d833b4cc8a68d639d2d
    }, { new: true })
        .then(todo => {
            if (!todo) {
                return res.status(404).send({
                    message: "todo not found with id " + req.params.todoId
                });
            }
            res.send(todo);
        }).catch(err => {
            if (err.kind === 'ObjectId') {
                return res.status(404).send({
                    message: "todo not found with id " + req.params.todoId
                });
            }
            return res.status(500).send({
                message: "Error updating todo with id " + req.params.todoId
            });
        });
};

// Delete a todo with the specified todoId in the request
exports.delete = (req, res) => {
    Todo.findByIdAndRemove(req.params.todoId)
        .then(todo => {
            if (!todo) {
                return res.status(404).send({
                    message: "todo not found with id " + req.params.todoId
                });
            }
            res.send({ message: "todo deleted successfully!" });
        }).catch(err => {
            if (err.kind === 'ObjectId' || err.name === 'NotFound') {
                return res.status(404).send({
                    message: "todo not found with id " + req.params.todoId
                });
            }
            return res.status(500).send({
                message: "Could not delete Todo with id " + req.params.todoId
            });
        });
};
