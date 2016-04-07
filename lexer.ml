# 1 "lexer.mll"
 
  open Parser
  exception Eof
  exception Unrecognized

# 8 "lexer.ml"
let __ocaml_lex_tables = {
  Lexing.lex_base = 
   "\000\000\235\255\236\255\002\000\003\000\004\000\005\000\241\255\
    \242\255\243\255\001\000\003\000\000\000\000\000\001\000\001\000\
    \002\000\003\000\019\000\031\000\019\000\011\000\002\000\007\000\
    \008\000\253\255\085\000\095\000\105\000\117\000\005\000\002\000\
    \008\000\251\255\005\000\248\255\250\255\012\000\006\000\021\000\
    \249\255\008\000\023\000\247\255\246\255\025\000\245\255\010\000\
    \244\255\239\255\238\255\237\255";
  Lexing.lex_backtrk = 
   "\255\255\255\255\255\255\018\000\018\000\020\000\020\000\255\255\
    \255\255\255\255\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\003\000\020\000\015\000\000\000\000\000\
    \000\000\255\255\255\255\003\000\003\000\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255";
  Lexing.lex_default = 
   "\001\000\000\000\000\000\255\255\255\255\255\255\255\255\000\000\
    \000\000\000\000\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \024\000\000\000\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\000\000\255\255\000\000\000\000\255\255\255\255\255\255\
    \000\000\255\255\255\255\000\000\000\000\255\255\000\000\255\255\
    \000\000\000\000\000\000\000\000";
  Lexing.lex_trans = 
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\022\000\022\000\022\000\022\000\023\000\000\000\022\000\
    \022\000\022\000\255\255\000\000\022\000\255\255\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \022\000\005\000\022\000\016\000\000\000\000\000\000\000\022\000\
    \000\000\000\000\007\000\009\000\000\000\008\000\018\000\021\000\
    \019\000\019\000\019\000\019\000\019\000\019\000\019\000\019\000\
    \019\000\019\000\024\000\020\000\003\000\006\000\004\000\051\000\
    \051\000\050\000\049\000\027\000\027\000\027\000\027\000\027\000\
    \027\000\027\000\027\000\027\000\027\000\027\000\025\000\019\000\
    \019\000\019\000\019\000\019\000\019\000\019\000\019\000\019\000\
    \019\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\011\000\037\000\000\000\026\000\013\000\015\000\040\000\
    \036\000\014\000\034\000\030\000\041\000\033\000\010\000\012\000\
    \047\000\045\000\044\000\035\000\017\000\031\000\033\000\032\000\
    \038\000\039\000\036\000\042\000\043\000\046\000\048\000\000\000\
    \029\000\000\000\029\000\000\000\026\000\028\000\028\000\028\000\
    \028\000\028\000\028\000\028\000\028\000\028\000\028\000\027\000\
    \027\000\027\000\027\000\027\000\027\000\027\000\027\000\027\000\
    \027\000\028\000\028\000\028\000\028\000\028\000\028\000\028\000\
    \028\000\028\000\028\000\000\000\026\000\028\000\028\000\028\000\
    \028\000\028\000\028\000\028\000\028\000\028\000\028\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\026\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \002\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \255\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000";
  Lexing.lex_check = 
   "\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\000\000\000\000\022\000\022\000\000\000\255\255\022\000\
    \023\000\023\000\024\000\255\255\023\000\024\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\000\000\022\000\000\000\255\255\255\255\255\255\023\000\
    \255\255\255\255\000\000\000\000\255\255\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\021\000\000\000\000\000\000\000\000\000\003\000\
    \004\000\005\000\006\000\018\000\018\000\018\000\018\000\018\000\
    \018\000\018\000\018\000\018\000\018\000\019\000\020\000\019\000\
    \019\000\019\000\019\000\019\000\019\000\019\000\019\000\019\000\
    \019\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\000\000\015\000\255\255\019\000\000\000\000\000\014\000\
    \016\000\000\000\030\000\017\000\013\000\032\000\000\000\000\000\
    \010\000\011\000\012\000\034\000\000\000\017\000\016\000\031\000\
    \037\000\038\000\039\000\041\000\042\000\045\000\047\000\255\255\
    \026\000\255\255\026\000\255\255\019\000\026\000\026\000\026\000\
    \026\000\026\000\026\000\026\000\026\000\026\000\026\000\027\000\
    \027\000\027\000\027\000\027\000\027\000\027\000\027\000\027\000\
    \027\000\028\000\028\000\028\000\028\000\028\000\028\000\028\000\
    \028\000\028\000\028\000\255\255\027\000\029\000\029\000\029\000\
    \029\000\029\000\029\000\029\000\029\000\029\000\029\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\027\000\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \024\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255";
  Lexing.lex_base_code = 
   "";
  Lexing.lex_backtrk_code = 
   "";
  Lexing.lex_default_code = 
   "";
  Lexing.lex_trans_code = 
   "";
  Lexing.lex_check_code = 
   "";
  Lexing.lex_code = 
   "";
}

let rec token lexbuf =
    __ocaml_lex_token_rec lexbuf 0
and __ocaml_lex_token_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 22 "lexer.mll"
                ( token lexbuf )
# 151 "lexer.ml"

  | 1 ->
# 23 "lexer.mll"
                ( token lexbuf )
# 156 "lexer.ml"

  | 2 ->
# 24 "lexer.mll"
                ( DBLSEMI )
# 161 "lexer.ml"

  | 3 ->
let
# 25 "lexer.mll"
             x
# 167 "lexer.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos lexbuf.Lexing.lex_curr_pos in
# 25 "lexer.mll"
                ( FLOAT (float_of_string x) )
# 171 "lexer.ml"

  | 4 ->
# 26 "lexer.mll"
               ( TRUE )
# 176 "lexer.ml"

  | 5 ->
# 27 "lexer.mll"
              ( FALSE )
# 181 "lexer.ml"

  | 6 ->
# 28 "lexer.mll"
                ( IF )
# 186 "lexer.ml"

  | 7 ->
# 29 "lexer.mll"
                ( THEN )
# 191 "lexer.ml"

  | 8 ->
# 30 "lexer.mll"
                ( ELSE )
# 196 "lexer.ml"

  | 9 ->
# 31 "lexer.mll"
                ( OR )
# 201 "lexer.ml"

  | 10 ->
# 32 "lexer.mll"
                ( AND )
# 206 "lexer.ml"

  | 11 ->
# 33 "lexer.mll"
                ( NOT )
# 211 "lexer.ml"

  | 12 ->
# 34 "lexer.mll"
                ( PLUS )
# 216 "lexer.ml"

  | 13 ->
# 35 "lexer.mll"
                ( MINUS )
# 221 "lexer.ml"

  | 14 ->
# 36 "lexer.mll"
                ( TIMES )
# 226 "lexer.ml"

  | 15 ->
# 37 "lexer.mll"
                ( DIVIDE )
# 231 "lexer.ml"

  | 16 ->
# 38 "lexer.mll"
                ( EQ )
# 236 "lexer.ml"

  | 17 ->
# 39 "lexer.mll"
                ( NEQ )
# 241 "lexer.ml"

  | 18 ->
let
# 40 "lexer.mll"
            s
# 247 "lexer.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos lexbuf.Lexing.lex_curr_pos in
# 40 "lexer.mll"
                ( COMPOP s )
# 251 "lexer.ml"

  | 19 ->
# 41 "lexer.mll"
                ( raise Eof )
# 256 "lexer.ml"

  | 20 ->
# 42 "lexer.mll"
                ( raise Unrecognized )
# 261 "lexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf; 
      __ocaml_lex_token_rec lexbuf __ocaml_lex_state

;;

