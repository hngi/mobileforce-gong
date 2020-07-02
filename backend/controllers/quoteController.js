const Quote = require('../models/quotes.js');
const quotes = require('../models/quotes.js');



exports.findAll = (req, res) => {
    Quote.find()
        .then(quotes => {
            res.send(quotes);
        }).catch(err => {
            res.status(500).send({
                message: err.message || "Some error occurred while retrieving notes."
            });
        });
};