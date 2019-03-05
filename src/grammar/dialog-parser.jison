
/* description: Parses and executes mathematical expressions. */

/* lexical grammar */
%lex
%%

\s+                        /* skip whitespace */
"dialog"                    return 'DIALOG'
"send"                      return 'SEND'
"prompt"                    return 'PROMPT'
\"(.*?)\"                   return 'TEXT'
\w+\b                       return 'TOKEN'
<<EOF>>                     return 'EOF'
.                           return 'INVALID'

/lex

/* operator associations and precedence */

%left 'TOKEN' 'PROMPT' 'SEND'

%start expressions

%% /* language grammar */

expressions
    : e EOF
        { $1; }
    ;

e
    : SEND TOKEN TEXT
        {{
          $$ = dialogVars[$2] = (session, args, next) => { session.send($3); next(); }
        }}
    | PROMPT TOKEN TEXT
        {{
          $$ = dialogVars[$2] = (session) => { require('botbuilder').Prompts.text(session, $3); }
        }}
    | DIALOG TEXT
        {$$ = global['dialogVars'] = [];}
    | TEXT
        {$$ = yytext;}
    | TOKEN
        {$$ = yytext;}
    ;
