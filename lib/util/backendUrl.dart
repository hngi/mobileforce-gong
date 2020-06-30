
/* Not everything route is listed here. Please check the route.js file and the controllers files
  in the backend folder to understand what to do. The api endpoints works!!*/

String baseRoute = 'gonghng.herokuapp.com'; //get request

String createNote = 'gonghng.herokuapp.com/notes'; //post request

//route for getting all notes of all users. not necessary... but...
String getAllNotes = 'gonghng.herokuapp.com/notes'; //get

String getAllImportantNotesOfAUser = 'gonghng.herokuapp.com/important'; //post 

//get notes of a particular user
String getAllNotesOfAUser =  'gonghng.herokuapp.com/notes/user'; //post request with ID

//get details about a note
String getANoteBYNoteID = 'gonghng.herokuapp.com/notes/noteID'; //get request. replace noteID with the ID of the note

//delete
String deleteNote = 'gonghng.herokuapp.com/note/noteID'; //delete request


String createTodo = 'gonghng.herokuapp.com/todo'; //post

String getCompletedTodoOfAUser = 'gonghng.herokuapp.com/completed'; //completed todo. get

String updateTodo = 'gonghng.herokuapp.com/todo/todoID'; //put request

String getAllTodoOfAUser = 'gonghng.herokuapp.com/todo/userID';

