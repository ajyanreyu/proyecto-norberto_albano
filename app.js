"use strict";

const express = require('express');
const app = express();
const path = require('path');
const expressLayouts = require('express-ejs-layouts');
const mongoose = require('mongoose'); 


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

var controller = require('./model/datascheme.js');

//app.get('/getFile', controller.getFile);
//console.log(controller.getFile());