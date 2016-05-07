(function (){
    
    var util = require("util");
    var mongoose = require("mongose");
    
    mongoose.connect('mongodb://localhost/csv');
    
    const schema = mongoose.Schema;
    const fileSavingSchema = mongoose.Schema({
        "name": String,
        "meta": String
    
    });
    
    const CSV = mongoose.model('CSV', fileSavingSchema);
    
    
    module.exports = CSV;

});