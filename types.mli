exception Desugar of string      (* Use for desugarer errors *)
exception Interp of string       (* Use for interpreter errors *)


type exprS = NumS of float 
		   | BoolS of bool 
		   | IfS of exprS * exprS * exprS 
    	   | OrS of exprS * exprS 
    	   | AndS of exprS * exprS 
    	   | NotS of exprS 
    	   | ArithS of string * exprS * exprS 
    	   | CompS of string * exprS * exprS 
           | EqS of exprS * exprS 
           | NeqS of exprS * exprS 
           | TupS of exprS list 
           | ListS of exprS list
           | CommentS
type exprC = NumC of float 
		   | BoolC of bool 
		   | IfC of exprC * exprC * exprC 
		   | ArithC of string  * exprC * exprC 
		   | CompC of string * exprC * exprC 
		   | EqC of exprC * exprC 
		   | TupC of exprC list
		   | ListC of exprC list
		   | CommentC
type value = Num of float 
		   | Bool of bool 
		   | Tup of value list
		   | List of value list
		   | Comment
(* Environment lookup *)
type 'a env
val empty : 'a env
val lookup : string -> 'a env -> 'a option
val bind :  string -> 'a -> 'a env -> 'a env


(* Interpreter steps *)
val desugar : exprS -> exprC 
val interp : value env -> exprC -> value 
val evaluate : exprC -> value 


(* result post-processing *)
val valToString : value -> string 
