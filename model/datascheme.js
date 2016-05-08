'use strict';

var mongoose = require('mongoose');

const programFile = mongoose.Schema({
    "name": String,
    "meta": String

});

const FILE = mongoose.model('FILE', programFile);

const fileData = mongoose.model('pl0', programFile);

exports.getFile =  () =>{
    //realizamos la conexion a la bbdd
    mongoose.connect('mongodb://localhost:pl0');
      return FILE.find({}, (err, doc) => {
            if (err) { console.log('ERROR: al recuperar los ficheros de la BBDD'); }
        }).then((valor) => {
            mongoose.connection.close();
            return valor.map((fileObj)  => { return [fileObj.name, fileObj.meta]; });
        });
};




