(function (){
    
    var util = require("util");
    var mongoose = require("mongose");
    
    mongoose.connect('mongodb://localhost/csv');
    
    const schema = mongoose.Schema;
    const programFile = mongoose.Schema({
        "name": String,
        "meta": String
    
    });
    
    const FILE = mongoose.model('FILE', programFile);
    
    
    module.exports = FILE;

});