exception Desugar of string      (* Used for desugarer errors *)
exception Interp of string       (* Used for interpreter errors *)
exception Lists of string        (* Used for list function errors *)

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
           | VarS of string
           | LetS of string * exprS * exprS
           | ListS of exprS list
           | FunS of string * string * exprS
           | FunS2 of string * exprS
           | CallS of exprS * exprS
           | HeadS of exprS 
           | TailS of exprS 
           | ListElS of exprS * exprS
           | ListEmS of exprS
           | ListPrepS of exprS * exprS
           | TupCarS of exprS
           | TupCdrS of exprS

type exprC = NumC of float 
           | BoolC of bool 
           | IfC of exprC * exprC * exprC 
           | ArithC of string  * exprC * exprC 
           | CompC of string * exprC * exprC 
           | EqC of exprC * exprC 
           | TupC of exprC list
           | VarC of string
           | LetC of string * exprC * exprC
           | ListC of exprC list
           | FunC of string * string * exprC 
           | FunC2 of string * exprC
           | CallC of exprC * exprC
           | HeadC of exprC 
           | TailC of exprC 
           | ListElC of exprC * exprC 
           | ListEmC of exprC
           | ListPrepC of exprC * exprC 
           | TupCarC of exprC
           | TupCdrC of exprC


(* Environment lookup *)
type 'a env
val empty : 'a env
val lookup : string -> 'a env -> 'a option
val bind :  string -> 'a -> 'a env -> 'a env

type value = Num of float 
           | Bool of bool 
           | Tup of value list
           | List of value list
           | Closure of value env * exprC

(* Interpreter steps *)
val desugar : exprS -> exprC 
val interp : value env -> exprC -> value 
val evaluate : exprC -> value 


(* result post-processing *)
val valToString : value -> string 
