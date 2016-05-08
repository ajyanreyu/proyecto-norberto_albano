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

st     = CL s1:st? r:(SC st)* SC* CR {
               /*console.log(s1);
               console.log(r);
               console.log(location()) /* atributos start y end */
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
        /FUNCTION id:ID p:param CL st:st CR
            {
              return {
                type: 'FUNCTION',
                name: id,
                inparam: p,
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
        /VAR c:assign? r:(CM assign)* SC
          {
            let t = [];
            if (c) t.push(c);
            return {
              type: 'VAR', // Chrome supports destructuring
              children: t.concat(r.map( ([_, r]) => r ))
            };
          }
          /CONST c:assign? r:(CM assign)* SC
            {
              let t = [];
              if (c) t.push(c);
              return {
                type: 'CONST', // Chrome supports destructuring
                children: t.concat(r.map( ([_, r]) => r ))
              };
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

call = i:ID p:param { return { type: 'call', id: i,  inparam: p } }

param = l:LEFTPAR  r:RIGHTPAR {return 'void';}
      / l:LEFTPAR v:(exp)+ r:RIGHTPAR {return v;}


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
