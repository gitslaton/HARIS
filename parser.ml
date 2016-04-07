type token =
  | FLOAT of (float)
  | TRUE
  | FALSE
  | DBLSEMI
  | IF
  | THEN
  | ELSE
  | OR
  | AND
  | NOT
  | PLUS
  | MINUS
  | TIMES
  | DIVIDE
  | COMPOP of (string)
  | EQ
  | NEQ

open Parsing;;
let _ = parse_error;;
# 2 "parser.mly"
  open Types
# 25 "parser.ml"
let yytransl_const = [|
  258 (* TRUE *);
  259 (* FALSE *);
  260 (* DBLSEMI *);
  261 (* IF *);
  262 (* THEN *);
  263 (* ELSE *);
  264 (* OR *);
  265 (* AND *);
  266 (* NOT *);
  267 (* PLUS *);
  268 (* MINUS *);
  269 (* TIMES *);
  270 (* DIVIDE *);
  272 (* EQ *);
  273 (* NEQ *);
    0|]

let yytransl_block = [|
  257 (* FLOAT *);
  271 (* COMPOP *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\000\000"

let yylen = "\002\000\
\002\000\001\000\001\000\001\000\001\000\006\000\003\000\003\000\
\002\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\002\000"

let yydefred = "\000\000\
\000\000\000\000\003\000\004\000\005\000\000\000\000\000\017\000\
\000\000\000\000\000\000\000\000\001\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\012\000\013\000\000\000\000\000\000\000\
\000\000\000\000\000\000"

let yydgoto = "\002\000\
\008\000\009\000\010\000"

let yysindex = "\002\000\
\098\255\000\000\000\000\000\000\000\000\098\255\098\255\000\000\
\015\255\081\255\060\255\124\255\000\000\098\255\098\255\098\255\
\098\255\098\255\098\255\098\255\098\255\098\255\098\255\099\255\
\099\255\127\255\127\255\000\000\000\000\049\255\124\255\124\255\
\071\255\098\255\081\255"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\020\255\000\000\042\255\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\254\254\
\113\255\014\255\028\255\000\000\000\000\048\255\119\255\125\255\
\000\000\000\000\100\255"

let yygindex = "\000\000\
\000\000\000\000\250\255"

let yytablesize = 141
let yytable = "\011\000\
\012\000\007\000\001\000\007\000\007\000\007\000\007\000\024\000\
\025\000\026\000\027\000\028\000\029\000\030\000\031\000\032\000\
\033\000\010\000\013\000\010\000\010\000\010\000\010\000\002\000\
\010\000\010\000\000\000\035\000\010\000\010\000\010\000\011\000\
\000\000\011\000\011\000\011\000\011\000\000\000\011\000\011\000\
\000\000\000\000\011\000\011\000\011\000\009\000\000\000\009\000\
\009\000\009\000\009\000\014\000\000\000\014\000\014\000\014\000\
\014\000\009\000\009\000\016\000\017\000\018\000\019\000\014\000\
\014\000\023\000\000\000\014\000\015\000\000\000\016\000\017\000\
\018\000\019\000\020\000\021\000\022\000\034\000\014\000\015\000\
\000\000\016\000\017\000\018\000\019\000\020\000\021\000\022\000\
\014\000\015\000\000\000\016\000\017\000\018\000\019\000\020\000\
\021\000\022\000\003\000\004\000\005\000\000\000\006\000\006\000\
\000\000\006\000\006\000\007\000\000\000\016\000\017\000\018\000\
\019\000\020\000\021\000\022\000\008\000\000\000\008\000\008\000\
\008\000\008\000\015\000\000\000\015\000\015\000\015\000\015\000\
\016\000\000\000\016\000\016\000\016\000\016\000\016\000\017\000\
\018\000\019\000\020\000\018\000\019\000"

let yycheck = "\006\000\
\007\000\004\001\001\000\006\001\007\001\008\001\009\001\014\000\
\015\000\016\000\017\000\018\000\019\000\020\000\021\000\022\000\
\023\000\004\001\004\001\006\001\007\001\008\001\009\001\004\001\
\011\001\012\001\255\255\034\000\015\001\016\001\017\001\004\001\
\255\255\006\001\007\001\008\001\009\001\255\255\011\001\012\001\
\255\255\255\255\015\001\016\001\017\001\004\001\255\255\006\001\
\007\001\008\001\009\001\004\001\255\255\006\001\007\001\008\001\
\009\001\016\001\017\001\011\001\012\001\013\001\014\001\016\001\
\017\001\006\001\255\255\008\001\009\001\255\255\011\001\012\001\
\013\001\014\001\015\001\016\001\017\001\007\001\008\001\009\001\
\255\255\011\001\012\001\013\001\014\001\015\001\016\001\017\001\
\008\001\009\001\255\255\011\001\012\001\013\001\014\001\015\001\
\016\001\017\001\001\001\002\001\003\001\255\255\005\001\004\001\
\255\255\006\001\007\001\010\001\255\255\011\001\012\001\013\001\
\014\001\015\001\016\001\017\001\004\001\255\255\006\001\007\001\
\008\001\009\001\004\001\255\255\006\001\007\001\008\001\009\001\
\004\001\255\255\006\001\007\001\008\001\009\001\011\001\012\001\
\013\001\014\001\015\001\013\001\014\001"

let yynames_const = "\
  TRUE\000\
  FALSE\000\
  DBLSEMI\000\
  IF\000\
  THEN\000\
  ELSE\000\
  OR\000\
  AND\000\
  NOT\000\
  PLUS\000\
  MINUS\000\
  TIMES\000\
  DIVIDE\000\
  EQ\000\
  NEQ\000\
  "

let yynames_block = "\
  FLOAT\000\
  COMPOP\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'headEx) in
    Obj.repr(
# 27 "parser.mly"
                                 ( _1 )
# 157 "parser.ml"
               : Types.exprS))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 31 "parser.mly"
                                 ( _1 )
# 164 "parser.ml"
               : 'headEx))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : float) in
    Obj.repr(
# 35 "parser.mly"
                                 ( NumS _1 )
# 171 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 36 "parser.mly"
                            ( BoolS true)
# 177 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 37 "parser.mly"
                           ( BoolS false)
# 183 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'expr) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 38 "parser.mly"
                                 ( IfS (_2, _4, _6) )
# 192 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 39 "parser.mly"
                              ( OrS (_1, _3) )
# 200 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 40 "parser.mly"
                             ( AndS (_1, _3) )
# 208 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 41 "parser.mly"
                             ( NotS (_2) )
# 215 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 42 "parser.mly"
                              ( ArithS ("+", _1, _3) )
# 223 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 43 "parser.mly"
                              ( ArithS ("-", _1, _3) )
# 231 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 44 "parser.mly"
                              ( ArithS ("*", _1, _3) )
# 239 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 45 "parser.mly"
                               ( ArithS ("/", _1, _3) )
# 247 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 46 "parser.mly"
                               ( CompS (_2, _1, _3) )
# 256 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 47 "parser.mly"
                              ( EqS (_1, _3) )
# 264 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 48 "parser.mly"
                             ( NeqS (_1, _3) )
# 272 "parser.ml"
               : 'expr))
(* Entry main *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let main (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Types.exprS)
