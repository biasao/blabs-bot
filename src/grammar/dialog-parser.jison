
/* description: Parses and executes mathematical expressions. */

/* lexical grammar */
%lex
%%

\s+                        /* skip whitespace */
([a-z]|[A-Z])+[0-9]*\b      return 'TOKEN'
"->"                        return 'TRANSITION'
"("                         return '('
")"                         return ')'
<<EOF>>                     return 'EOF'
.                           return 'INVALID'

/lex

/* operator associations and precedence */

%left 'TRANSITION'
%left 'TOKEN'

%start expressions

%% /* language grammar */

expressions
    : e EOF
        { return $1; }
    ;

e
    : TOKEN
        {$$ = yytext;}
    | TOKEN TRANSITION TOKEN
        {{
          $$ = ([ function (session) { session.send("Welcome to the bedroom reservation service."); require('botbuilder').Prompts.time(session, "Please provide a reservation date and time (e.g.: June 6th at 5pm)"); } ]);          
        }}
    ;
