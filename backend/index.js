var express = require('express');
var bodyParser = require('body-parser');
const config = require('./db/config');
const mongoose = require('mongoose');
require("dotenv").config();
// const morgan = require('morgan');
const app = express();
const port = process.env.PORT || 3000;
const route = require('./routes');


app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());
// app.use(morgan('short')) //real time activity update in console
app.use(route);

mongoose.Promise = global.Promise;

//Connecting to database


mongoose.connect(encodeURI(process.env.MONGOLABURI, {
    useUnifiedTopology: true,
    useNewUrlParser: true
})).then(() => {
    console.log('Successfully Connected');
}).catch(err => {
    console.log('could not connect');
    process.exit();
})

mongoose.set("useFindAndModify", false);
mongoose.set('useCreateIndex', true);

// define a simple route

app.listen(port, ()=>{
    console.log(`Server is listen on port ${port}`)
});
