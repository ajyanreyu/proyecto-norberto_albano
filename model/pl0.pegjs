/*
 * PEGjs for a "Pl-0" like language
 * Used in ULL PL Grado de Informática classes
 */

{
  var tree = function(f, r) {
    if (r.length > 0) {
      var last = r.pop();
      var result = {
        type:  last[0],
        left: tree(f, r),
        right: last[1]
      };
    }
    else {
      var result = f;
    }
    return result;
  }
}

program = b:block { b.name = {type: 'ID', value: "$main"}; b.params = []; return b;}

block = cD:constantDeclaration? vD:variableDeclaration? fD:functionDeclaration* st:st
            {
                let constants =  cD? = [cD] : [];
                let variables = vD? = [vD] : [];
                return{
                    type: 'BLOCK',
                    constants: constants,
                    variables: variables,
                    functions: fD,
                    main: st
                }
                
            }

constantDeclaration = CONST id:ID ASSIGN n:NUMBER rest:(COMMA ID ASSIGN NUMBER)* SC
            {
              let r = rest.map( ([_, id, __, nu]) => [id.value, nu.value] );
              return [[id.value, n.value]].concat(r) 
            }

variableDeclaration = VAR id:ID rest:(COMMA ID)* SC
          {
            let r = rest.map( ([_, id]) => id.value );
            return [id.value].concat(r) 
          }

functionDeclaration = FUNCTION id:ID LEFTPAR a:ID? p1:(COMMA ID)* RIGHTPAR b:block SC 
            {
                let params = p1? [p1] : [];
                params: params.concat(r.map([_, p] => p));
              return {
                type: 'FUNCTION',
                name: id,
                inparam: params,
                st:st
              }
            }

st     = CL s1:st? r:(SC st)* SC* CR {
               let t = [];
               if (s1) t.push(s1);
               return {
                 type: 'COMPOUND', // Chrome supports destructuring
                 children: t.concat(r.map( ([_, st]) => st ))
               };
            }
       / IF e:assign THEN st:st ELSE sf:st
           {
             return {
               type: 'IFELSE',
               c:  e,
               st: st,
               sf: sf,
             };
           }
       / IF e:assign THEN st:st
           {
             return {
               type: 'IF',
               c:  e,
               st: st
             };
           }
       / WHILE e:assign DO st:st
            {
              return{
                type: 'WHILEDO',
                c: e,
                st:st
              }
            }
        
        /RETURN f:cond SC
          {
            return {
              type: 'RETURN',
              children: t.concat(r.map( ([_, st]) => st ))
            }
          }
       /assign

assign = i:ID ASSIGN c:call
            {return {type: '=', left:i, right:c }}
       /i:ID ASSIGN e:cond
            { return {type: '=', left: i, right: e}; }
       / cond


cond = l:call op:COMP r:exp { return { type: op, left: l, right: r} }
    / l:exp op:COMP r:exp { return { type: op, left: l, right: r} }
    /exp

call = id:ID LEFTPAR a:assign? r:(COMMA assign)* RIGHTPAR 
        { 
            let c = a? [a] : [];
            c = c.concat(r.map([_, t] => t));
            return { 
                type: 'CALL', 
                name: id,
                parameter: c 
                
            }
        }


exp   = t:term   r:(ADD term)*   { return tree(t,r); }


term   = f:factor r:(MUL factor)* { return tree(f,r); }

factor = call
       /NUMBER
       / ID
       / LEFTPAR t:assign RIGHTPAR   { return t; }


_ = $[ \t\n\r]*

ASSIGN   = _ op:'=' _  { return op; }
ADD      = _ op:[+-] _ { return op; }
MUL      = _ op:[*/] _ { return op; }
LEFTPAR  = _"("_
RIGHTPAR = _")"_
CL       = _"{"_
CR       = _"}"_
SC       = _";"_
CM       = _ "," _
COMP     = _ op:("=="/"!="/"<="/">="/"<"/">") _ {
               return op;
            }
IF       = _ "if" _
THEN     = _ "then" _
ELSE     = _ "else" _
WHILE    = _ "while" _
DO       = _ "do" _
FUNCTION = _ "function" _
RETURN   = _ "return" _
VAR      = _ "var"_
CONST    = _ "const" _
ID       = _ id:$([a-zA-Z_][a-zA-Z_0-9]*) _
            {
              return { type: 'ID', value: id };
            }
NUMBER   = _ digits:$[0-9]+ _
            {
              return { type: 'NUM', value: parseInt(digits, 10) };
            }
