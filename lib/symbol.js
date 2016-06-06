"use strict"

class SymbolBase {
    
    constructor(id, location){
        this.id = id;
        this.location = location;
    }
    
    to_s(){
        return this.id;
    }
    
    where(){
        return this.location;
    }
}

class Constants extends SymbolBase {
    
    constructor(id, location){
        super(id, location);
    }
    
    type(){
        return "constant";
    }
}

class Variables extends SymbolBase{
    
    constructor(id, value, location){
        super(id, location);
        this.value = value;
    }
    
     type(){
        return "variable";
    }

    
}

class Functions extends SymbolBase{
    
    constructor(id, params, location){
        super(id, location);
        this.params = params;
    }
    
     type(){
        return "function";
    }
}

module.exports.Constants = Constants;
module.exports.Variables = Variables;
module.exports.Functions = Functions;