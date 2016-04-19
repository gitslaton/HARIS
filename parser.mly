%{
  open Types
%}


%token <string> VAR 
%token <float> FLOAT 
%token <string> COMPOP
%token FUN_DECL 
%token TRUE FALSE 
%token DBLSEMI 
%token IF THEN ELSE USE
%token LET
%token EQUAL
%token IN
%token OR OR2 AND AND2 NOT 
%token PLUS MINUS TIMES DIVIDE 
%token EQ NEQ 
%token CURLY_L COMMA CURLY_R 
%token CARROT_L DOLLAR CARROT_R 
%token PAREN_L PAREN_R 
%token BRACK_L BRACK_R 
%token DOT COLON
%token HEAD TAIL PREPEND EMPTY
%token CAR CDR
%token NUM_T BOOL_T  LIST_T TUP_T
%nonassoc LET
%nonassoc IN
%left OR OR2 AND AND2
%left EQ NEQ NOT
%left IF THEN ELSE USE
%right HEAD TAIL PREPEND EMPTY
%right CAR CDR
%nonassoc DOT
%nonassoc COMPOP
%left PLUS MINUS
%left TIMES DIVIDE
%nonassoc FLOAT



%start main
%type <Types.exprS> main
%%




main:
  | headEx DBLSEMI                    { $1 }
;

headEx:
  | expr                              { $1 }
  | LET VAR EQUAL expr                { GLetS ($2, $4) }
;

expr_lst:
  | headEx                            { [$1] }
  | headEx COMMA expr_lst             { $1 :: $3 }
  | headEx DOLLAR expr_lst            { $1 :: $3 }
;

expr_T:
  | NUM_T                             { NumT }
  | BOOL_T                            { BoolT }
  | LIST_T expr_T                     { ListT $2}
  | TUP_T                             { TupT []}
;

expr:
  | VAR                                                                                                      { VarS $1 }
  | FLOAT                                                                                                    { NumS $1 }
  | TRUE                                                                                                     { BoolS true }
  | FALSE                                                                                                    { BoolS false }
  | IF expr THEN expr ELSE expr                                                                              { IfS ($2, $4, $6) } 
  | expr OR expr                                                                                             { OrS ($1, $3) } 
  | expr OR2 expr                                                                                            { OrS ($1, $3) } 
  | expr AND expr                                                                                            { AndS ($1, $3) } 
  | expr AND2 expr                                                                                           { AndS ($1, $3) } 
  | NOT expr                                                                                                 { NotS ($2) } 
  | expr PLUS expr                                                                                           { ArithS ("+", $1, $3) }
  | expr MINUS expr                                                                                          { ArithS ("-", $1, $3) }
  | expr TIMES expr                                                                                          { ArithS ("*", $1, $3) } 
  | expr DIVIDE expr                                                                                         { ArithS ("/", $1, $3) } 
  | expr COMPOP expr                                                                                         { CompS ($2, $1, $3) } 
  | expr EQ expr                                                                                             { EqS ($1, $3) }
  | expr NEQ expr 	                                                                                         { NeqS ($1, $3) }
  | CURLY_L CURLY_R                                                                                          { TupS [] } 
  | CURLY_L expr_lst CURLY_R                                                                                 { TupS $2 }
  | CARROT_L CARROT_R                                                                                        { ListS [] }
  | CARROT_L expr_lst CARROT_R                                                                               { ListS ($2) }
  | LET VAR EQUAL expr IN expr                                                                               { LetS ($2, $4, $6) }
  | BRACK_L FUN_DECL VAR BRACK_L VAR COLON expr_T BRACK_R EQUAL BRACK_L expr COLON expr_T BRACK_R BRACK_R    { GLetS ($3, FunS ($3, $5, $7, $11, $13)) }
  | BRACK_L FUN_DECL BRACK_L VAR COLON expr_T BRACK_R EQUAL BRACK_L expr COLON expr_T BRACK_R BRACK_R        { FunS2 ($4, $6, $10, $12) }
  | USE expr expr                                                                                            { CallS ($2, $3) }
  | expr DOT HEAD                                                                                            { HeadS ($1) } 
  | expr DOT TAIL                                                                                            { TailS ($1) } 
  | expr DOT FLOAT                                                                                           { ListElS ($1, NumS $3) }
  | expr DOT EMPTY                                                                                           { ListEmS ($1) }
  | expr DOT PREPEND DOT expr                                                                                { ListPrepS ($1, $5) }
  | expr DOT CAR                                                                                             { TupCarS ($1) } 
  | expr DOT CDR                                                                                             { TupCdrS ($1) } 
;

