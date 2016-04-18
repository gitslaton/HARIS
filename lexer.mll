{
  open Parser
  exception Eof
  exception Unrecognized
}

let any = _
let digit = ['0'-'9']
let sign = ['+' '-']
let frac = '.' digit+
let exp = ['e' 'E'] sign? digit+
let white = [' ' '\t' '\n' '\r']+ | "//" ([^ '\n' '\r'])*
let newline = '\n' | '\r' | "\r\n"
let alpha_num = ['a'-'z' 'A'-'Z' '_']+ ['a'-'z' 'A'-'Z' '_' '0'-'9']*
let comm = "+-" ['0'-'9' 'a'-'z' 'A'-'Z' '_' ''' '[' ']' '^' '!' '@' '$' '%' '&' '*' '(' ')' '{' '}' ';' '"' '.' '?' '>' '<' '+' ',' '/' '-' '+' ' ' '\t' '\r']*  "-+" 
let dblsemi = ";;"
let float = (digit+ '.'? | digit* frac) exp?
let true = "true" | "#t" 
let false = "false" | "#f" 
let comp = ">" | ">=" | "<" | "<=" 




rule token = parse
  | white                   { token lexbuf }
  | newline                 { token lexbuf }
  | dblsemi                 { DBLSEMI }
  | float as x              { FLOAT (float_of_string x) }
  | "NUM"                   { NUM_T}
  | "BOOL"                  { BOOL_T }
  | true 		                { TRUE } 
  | false 		              { FALSE }
  | "LET"                   { LET }
  | "IN"                    { IN }
  | "IF"                    { IF }
  | "THEN"                  { THEN }
  | "ELSE"                  { ELSE }
  | "OR"                    { OR }
  | "||"                    { OR2 }
  | "AND"                   { AND }
  | "&&"                    { AND2 }
  | "NOT"                   { NOT }
  | ":"                     { COLON }
  | "+"                     { PLUS }
  | "-"                     { MINUS }
  | "*"                     { TIMES }
  | "/"                     { DIVIDE } 
  | "=="                    { EQ }
  | "!="                    { NEQ }
  | "{"                     { CURLY_L }
  | "}"                     { CURLY_R }
  | ","                     { COMMA }
  | "("                     { PAREN_L }
  | ")"                     { PAREN_R }
  | "["                     { BRACK_L } 
  | "]"                     { BRACK_R }
  | "="                     { EQUAL } 
  | "{^"                    { CARROT_L }
  | "^}"                    { CARROT_R }
  | "$"                     { DOLLAR }
  | "SKIADAS"               { FUN_DECL}
  | "."                     { DOT }
  | "HEAD"                  { HEAD }
  | "TAIL"                  { TAIL }
  | "EMPTY"                 { EMPTY }
  | "PREPEND"               { PREPEND }
  | "CAR"                   { CAR }
  | "CDR"                   { CDR }
  | "USE"                   { USE }
  | comp as s               { COMPOP s }
  | comm                    { token lexbuf }
  | eof                     { raise Eof }
  | alpha_num as a          { VAR a }
  | any                     { raise Unrecognized }

 