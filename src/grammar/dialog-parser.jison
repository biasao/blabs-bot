
/* description: Parses and executes mathematical expressions. */

/* lexical grammar */
%lex
%%

\s+                        /* skip whitespace */
\"(.*?)\"                   return 'TEXT'
"->"                        return 'TRANSITION'
"send"                      return 'SEND'
"prompt"                    return 'PROMPT'
<<EOF>>                     return 'EOF'
.                           return 'INVALID'

/lex

/* operator associations and precedence */

%left 'TRANSITION'
%left 'SEND'
%left 'PROMPT'

%start expressions

%% /* language grammar */

expressions
    : e EOF
        { return $1; }
    ;

e
    : e TRANSITION e
        {{
          $$ = function (session) { $1; $3; };
        }}
    | SEND e
        {{
          $$ = function (session) { session.send($2); }
        }}
    | PROMPT e
        {{
          $$ = function (session) { require('botbuilder').Prompts.text(session, $2) }
        }}
    | TEXT
        {$$ = yytext;}
    ;
