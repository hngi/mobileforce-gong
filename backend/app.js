require("dotenv").config();
const express = require('express');
const bodyParser = require("body-parser");
const mongoose = require("mongoose");
const cors = require('cors');

const app = express();

app.use(bodyParser.urlencoded({ extended: true }));
app.use(cors());


mongoose.connect(process.env.MONGOURI, 
{useNewUrlParser: true, useUnifiedTopology: true})
.then(() => {
    console.log("Connection successfully, to mongoDb Atlas");
})
.catch((error) => {
    console.log("could not connect");
    console.error(error);
});

mongoose.set("useFindAndModify", false);
mongoose.set('useCreateIndex', true);
// mongoose.set("useNewUrlParser", true)
// mongoose.set("useUnifiedTopology", true)

const todoSchema = new mongoose.Schema({
    title: { type: String, required: true, unique: true },
    description: { type: String },
    date: {type: Date, default: Date.now },
    priority: { type: Boolean }
  });
  
  
  const Todo = mongoose.model("Todo", todoSchema);

  
app
.route("/todo")

.get(function (req, res) {
  Todo.find(function (err, foundTodos) {
    if (!err) {
      res.send(foundTodos);
    } else {
      res.send(err);
    }
  });
})

.post(function (req, res) {
  const newTodo = new Todo({
    title: req.body.title,
    description: req.body.description,
    priority: req.body.priority
  });

  newTodo.save(function (err) {
    if (!err) {
      res.send("Successfuly added a new Todo.");
    } else {
      res.send(err);
    }
  });
})

.delete(function (req, res) {
  Todo.deleteMany(function (err) {
    if (!err) {
      res.send("Successfuly deleted a all Todo.");
    } else {
      res.send(err);
    }
  });
});

app
  .route("/todos/:todoTitle")

  .get(function (req, res) {
    Todo.findOne({ title: req.params.todoTitle }, function (
      err,
      foundTodo
    ) {
      if (foundTodo) {
        res.send(foundTodo);
      } else {
        console.log(err);
        res.send("No Todos matching that title was found.");
      }
    });
  })

  .put(function (req, res) {
    Todo.update(
      { title: req.params.todoTitle },
      { title: req.body.title, description: req.body.description, priority: req.body.priority },
      { overwrite: true },
      function (err) {
        if (!err) {
          res.send("Successfully updated Todo.");
        } else {
          res.send("An error occurred.");
        }
      }
    );
  })

  .patch(function (req, res) {
    Todo.update(
      { title: req.params.todoTitle },
      { $set: req.body },
      function (err) {
        if (!err) {
          res.send("Successfully updated Todo.");
        } else {
          res.send("An error occurred.");
        }
      }
    );
  })

  .delete(function (req, res) {
    Todo.deleteOne({ title: req.params.todoTitle }, function (err) {
      if (!err) {
        res.send("Successfully deleted Todo.");
      } else {
        res.send("An error occurred.");
      }
    });
  });


  app.listen(3000, function () {
    console.log("Server started on port 3000");
  });
  