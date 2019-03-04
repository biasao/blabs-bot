
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

%start expressions

%% /* language grammar */

expressions
    : e EOF
        { return $1; }
    ;

e
    : e TRANSITION e
        {{
          $$ = function (session) { session.send($1); require('botbuilder').Prompts.text(session, $3); };
        }}
    | TOKEN
        {$$ = yytext;}
    ;
