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
let dblsemi = ";;"
let float = (digit+ '.'? | digit* frac) exp?
let true = "true" | "#t" 
let false = "false" | "#f" 
let comp = ">" | ">=" | "<" | "<=" 




rule token = parse
  | white       { token lexbuf }
  | newline     { token lexbuf }
  | dblsemi     { DBLSEMI }
  | float as x  { FLOAT (float_of_string x) }
  | true 		    { TRUE } 
  | false 		  { FALSE }
  | "if"        { IF }
  | "then"      { THEN }
  | "else"      { ELSE }
  | "or"        { OR }
  | "and"       { AND }
  | "not"       { NOT }
  | "+"         { PLUS }
  | "-"         { MINUS }
  | "*"         { TIMES }
  | "/"         { DIVIDE } 
  | "=="        { EQ }
  | "!="        { NEQ }
  | "{"         { CURLY_L }
  | "}"         { CURLY_R }
  | ","         { COMMA }
  | "("         { PAREN_L }
  | ")"         { PAREN_R }
  | "["         { BRACK_L } 
  | "]"         { BRACK_R }
  | "="         { EQUAL } 
  | comp as s   { COMPOP s }
  | eof         { raise Eof }
  | any         { raise Unrecognized }
