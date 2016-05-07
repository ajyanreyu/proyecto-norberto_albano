"use strict";

const express = require('express');
const app = express();
const path = require('path');
const expressLayouts = require('express-ejs-layouts');

app.set('port', (process.env.PORT || 5000));

app.set('views', path.join(__dirname, '/public/views'));
app.set('view engine', 'ejs');
app.use(expressLayouts);

app.use(express.static(__dirname + '/public'));

//const calculate = require('./models/calculate.js');

app.get('/', (request, response) => {
  response.render('index',{title: "PL/0"});
});

/*app.get('/csv', (request, response) => {
  response.send({"rows": calculate(request.query.input)})
});*/

app.listen(app.get('port'), () => {
    console.log(`Node app is running at localhost: ${app.get('port')}` );
});

const Entrada = require('./model/dataschema.js');

app.get('/mongo/', function(req, res) {
    Entrada.find({}, function(err, docs) {
        if (err)
            return err;
        if (docs.length >= 4) {
            Entrada.find({ name: docs[3].name }).remove().exec();
        }
    });
    let input = new Entrada({
        "name": req.query.name,
        "content": req.query.content
    });
});