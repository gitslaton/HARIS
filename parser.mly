%{
  open Types
%}

%token <float> FLOAT
%token TRUE FALSE
%token DBLSEMI 
%token IF THEN ELSE 
%token OR AND NOT 
%token PLUS MINUS TIMES DIVIDE 
%token COMMENT_L COMMENT_R
%token <string> COMPOP
%token EQ NEQ 
%token CURLY_L COMMA CURLY_R
%token CARROT_L DOLLAR CARROT_R
%token PAREN_L PAREN_R
%token BRACK_L BRACK_R
%token EQUAL
%nonassoc FLOAT
%nonassoc ELSE
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
  | headEx DBLSEMI               { $1 }
;

headEx:
  | expr                         { $1 }
;

expr_lst:
  | headEx                            { [$1] }
  | headEx COMMA expr_lst            { $1 :: $3 }
  | headEx DOLLAR expr_lst            { $1 :: $3 }
;

comment_lst:
  | headEx { }
;
expr:
  | FLOAT                           { NumS $1 } 
  | TRUE 						                { BoolS true} 
  | FALSE 						              { BoolS false}
  | CURLY_L CURLY_R                 {TupS []} 
  | CURLY_L expr_lst CURLY_R       { TupS $2 }
  | COMMENT_L comment_lst COMMENT_R         {CommentS}
  | IF expr THEN expr ELSE expr     { IfS ($2, $4, $6) } 
  | expr OR expr 				            { OrS ($1, $3) } 
  | expr AND expr 				          { AndS ($1, $3) } 
  | NOT expr 					              { NotS ($2) } 
  | expr PLUS expr 				          { ArithS ("+", $1, $3) }
  | expr MINUS expr 			          { ArithS ("-", $1, $3) }
  | expr TIMES expr 			          { ArithS ("*", $1, $3) } 
  | expr DIVIDE expr 			          { ArithS ("/", $1, $3) } 
  | expr COMPOP expr 			          { CompS ($2, $1, $3) } 
  | expr EQ expr 				            { EqS ($1, $3) }
  | expr NEQ expr 				          { NeqS ($1, $3) }
  | CARROT_L CARROT_R                   {ListS []}
  | CARROT_L expr_lst CARROT_R         { ListS ($2) }
;