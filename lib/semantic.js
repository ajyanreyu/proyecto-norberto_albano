(() => {
    var semantic = (tree) => {
        var emptySymbolTable = {};
        eachBlockPre(tree, makeTable, emptySymbolTable);
    };

    var eachBlockPre = (tree, action, f) => {
        action(tree, f);
        tree.functions.forEach((func) => eachBlockPre(func, action, tree.symbolTable));
    };

    var makeTable = (block, fatherTable) => {
        block.symbolTable = {
            father: fatherTable
        };
        
    };
    
})();