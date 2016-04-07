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

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Types.exprS
