const express = require('express');
const router = express.Router();

const notes = require('./controllers/noteController.js');
const todo = require('./controllers/todoControllers.js');
const quote = require('./controllers/quoteController.js');


//defining a simple route
router.get('/', (req, res) => {
    res.json({"message": "Welcome to EasyNotes application. Take notes quickly. Organize and keep track of all your notes."});
});


// Create a new Note
router.post('/notes', notes.create);

// Retrieve all Notes
router.get('/notes', notes.findAll);

router.post('/important', notes.findImportant);

// Retrieve a single Note with noteId
router.get('/notes/:noteId', notes.findOne);

// Retrieve a single Note with userID
router.post('/notes/user', notes.findByUser);

// Update a Note with noteId
router.put('/notes/:noteId', notes.update);

// Delete a Note with noteId
router.delete('/notes/:noteId', notes.delete);


router.post('/todo', todo.create);

// Retrieve all Notes
router.post('/todo/user', todo.findAll);

router.get('/completed', todo.findImportant);

// Retrieve a single Note with noteId
router.get('/todo/:todoId', todo.findOne);

// Retrieve a single Note with userID
router.get('/todo/:userId', todo.findOneByUser);

// Update a Note with noteId
router.put('/todo/:todoId', todo.update);

// Delete a Note with noteId
router.delete('/todo/:todoId', todo.delete);


//get quotes from db
router.get('/quotes', quote.findAll);


module.exports = router;