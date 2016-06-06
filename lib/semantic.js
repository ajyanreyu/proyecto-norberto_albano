(() => {
    var Errors ='';
    var semantic = (tree) => {
        var emptySymbolTable = {};
        eachBlockPre(tree, buildTable, emptySymbolTable);
    };

    var eachBlockPre = (tree, action, f) => {
        action(tree, f);
        tree.functions.forEach((func) => eachBlockPre(func, action, tree.symbolTable));
    };
    
    //creamos la tabla para el nodo
    var buildTable = (node, fatherTable) => {
        nodo.symbolTable = {
            father: fatherTable
        };
        node.constants.forEach((constants) => insert(constants, node.symbolTable));
        node.variable.forEach((variable) => insert(variable, node.symbolTable));
        node.functions.forEach((functions) => insert(functions, node.symbolTable));
    };
    var insert = (symbol, symbolTable) =>
})();