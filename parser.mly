%{
  open Types
%}

%token <float> FLOAT
%token <string>VAR
%token ARROWS
%token FUN_DECL
%token GROUP
%token TRUE FALSE
%token DBLSEMI 
%token IF THEN ELSE 
%token OR AND NOT 
%token PLUS MINUS TIMES DIVIDE 
%token <string> COMPOP
%token EQ NEQ 
%token CURLY_L COMMA CURLY_R
%token CARROT_L DOLLAR CARROT_R
%token PAREN_L PAREN_R
%token BRACK_L BRACK_R
%token EQUAL
%token LET IN 
%nonassoc FLOAT
%nonassoc ELSE
%nonassoc FUN_DECL
%nonassoc LET IN
%left OR AND 
%nonassoc EQ NEQ 
%nonassoc NOT 
%nonassoc COMPOP 
%left PLUS MINUS 
%left TIMES DIVIDE 


%start main
%type <Types.exprS> main
%%

main:
  | headEx DBLSEMI                    { $1 }
;

headEx:
  | expr                              { $1 }
;

expr_lst:
  | headEx                            { [$1] }
  | headEx COMMA expr_lst             { $1 :: $3 }
  | headEx DOLLAR expr_lst            { $1 :: $3 }
;

expr_group:
  | DOLLAR PAREN_L expr PAREN_R ARROWS PAREN_L expr PAREN_R               { ($3, $7) }
  | DOLLAR PAREN_L expr PAREN_R ARROWS PAREN_L expr PAREN_R expr_group    { ($3, $7) :: $9 }
;

expr_func:
  | FUN_DECL VAR BRACK_L expr BRACK_R EQUAL BRACK_L expr BRACK_R         { FunS ($2, $4, $8) }
  | FUN_DECL VAR EQUAL BRACK_L expr BRACK_R                              { FunS ($2, $5) }
;

expr:
  | VAR                                           { VarS $1 } 
  | LET VAR EQUAL expr IN expr                    { LetS ($2, $4, $6) }
  | VAR EQUAL expr                                { VarS ($3) }
  | FLOAT                                         { NumS $1 } 
  | TRUE 						                              { BoolS true } 
  | FALSE 						                            { BoolS false }
  | CURLY_L CURLY_R                               { TupS [] } 
  | CURLY_L expr_lst CURLY_R                      { TupS $2 }
  | IF expr THEN expr ELSE expr                   { IfS ($2, $4, $6) } 
  | expr OR expr 				                          { OrS ($1, $3) } 
  | expr OR' expr 				                        { OrS ($1, $3) } 
  | expr AND expr 				                        { AndS ($1, $3) } 
  | expr AND' expr 				                        { AndS ($1, $3) } 
  | NOT expr 					                            { NotS ($2) } 
  | expr PLUS expr 				                        { ArithS ("+", $1, $3) }
  | expr MINUS expr 			                        { ArithS ("-", $1, $3) }
  | expr TIMES expr 			                        { ArithS ("*", $1, $3) } 
  | expr DIVIDE expr 			                        { ArithS ("/", $1, $3) } 
  | expr COMPOP expr 			                        { CompS ($2, $1, $3) } 
  | expr EQ expr 				                          { EqS ($1, $3) }
  | expr NEQ expr 				                        { NeqS ($1, $3) }
  | CARROT_L CARROT_R                             { ListS [] }
  | CARROT_L expr_lst CARROT_R                    { ListS ($2) }
  | GROUP PAREN_L expr PAREN_R IN expr_group      { GroupS ($3, $6) }
  | BRACK_L expr_func BRACK_R                     { FunS ($2) }
;
