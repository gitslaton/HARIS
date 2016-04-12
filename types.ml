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
           | VarS of string
           | LetS of string * exprS * exprS
           | ListS of exprS list
           | GroupS of exprS * (exprS * exprS) list
           | FunS of string * exprS list * exprS
           | FunS' of string * exprS

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
           | GroupC of exprC * (exprC * exprC) list
           | FunC of string * exprC list * exprC 
           | FunC' of string * exprC

type value = Num of float 
           | Bool of bool 
           | Tup of value list
           | List of value list 


type 'a env = (string * 'a) list
let empty = []

(* lookup : string -> 'a env -> 'a option *)
let rec lookup str env = match env with
  | []          -> None
  | (s,v) :: tl -> if s = str then Some v else lookup str tl 

(* val bind :  string -> 'a -> 'a env -> 'a env *)
let bind str v env = (str, v) :: env


(*HELPER METHODS*)
(*
let rec map function lst = 


let rec filter fun_bool lst = 


let rec foldr fun_a_b lst x = 


let rec foldl fun_a_b x lst = 


*)

let arithEval str_operator val_l val_r = 
  match (val_l, val_r) with
  | (Num val_l', Num val_r') -> (match str_operator with
                                 | "+" -> Num (val_l' +. val_r')
                                 | "-" -> Num (val_l' -. val_r')
                                 | "*" -> Num (val_l' *. val_r')
                                 | "/" -> (match val_r' with
                                           | 0. -> raise (Interp "Division by 0")
                                           | _ -> Num (val_l' /. val_r'))
                                 | _ -> raise (Interp "Not an Operator"))
  | _ -> raise (Interp "Not Both Nums") 

let compEval str_operator val_l val_r = 
  match (val_l, val_r) with
  | (Num val_l', Num val_r') -> (match str_operator with
                                 | "<" -> Bool (val_l' < val_r')
                                 | "<=" -> Bool (val_l' <= val_r')
                                 | ">" -> Bool (val_l' > val_r')
                                 | ">=" -> Bool (val_l' >= val_r')
                                 | _ -> raise (Interp "Not an Operator"))
  | _ -> raise (Interp "Not Both Nums") 
(*
   Write a function `map` that takes as input a function `'a -> 'b` and a `'a stream`,
   and produces a `'b stream` whose values are the results of applying the function
   to the corresponding values of the 'a stream. For example if st is the stream
   1, 2, 3, ... and the function is the squaring function, the resulting stream would
   be 1, 4, 9, ...
   It should have type `('a -> 'b) -> 'a stream -> 'b stream`.
*)
(*ISSUES: has type ('a * 'a stream -> 'b) -> 'a stream -> 'b stream*)
let rec map f (St th) =
   let (v, st) = th () in
      St (fun () -> (f v, map f st))
let eqEval val_l val_r = 
  match (val_l, val_r) with 
  | (Num val_l', Num val_r') -> Bool (val_l' = val_r')
  | (Bool val_l', Bool val_r') -> Bool (val_l' = val_r')
  | _ -> Bool false 



(* INTERPRETER *)
(* desugar : exprS -> exprC *)
let rec desugar exprS = match exprS with
                        | NumS i -> NumC i
                        | BoolS b -> BoolC b
                        | IfS (test, option1, option2) -> IfC (desugar test, desugar option1, desugar option2) 
                        | NotS n -> IfC (desugar n, BoolC false, BoolC true) 
                        | OrS (o1, o2) -> IfC (desugar o1, BoolC true, IfC (desugar o2, BoolC true, BoolC false)) 
                        | AndS (a1, a2) -> IfC (desugar a1, IfC (desugar a2, BoolC true, BoolC false), BoolC false) 
                        | ArithS (str_operator, NumS val_l, NumS val_r) -> ArithC (str_operator, NumC val_l, NumC val_r) 
                        | CompS (str_operator, NumS val_l, NumS val_r) -> CompC (str_operator, NumC val_l, NumC val_r) 
                        | EqS (val_l, val_r) -> EqC (desugar val_l, desugar val_r) 
                        | NeqS (val_l, val_r) -> desugar (NotS (EqS (val_l, val_r)))
                        | ListS list_val      -> ListC (List.map desugar list_val)
                        | LetS (var, expr1, expr2) -> LetC (var, desugar expr1, desugar expr2)
                        | TupS list_val -> TupC (List.map desugar list_val)
                        | VarS k-> VarC k
                        (*ISSUES, ISSUES, ISSUES*)                        
                        | FunS (name, parameter, body) -> FunC (name, desugar parameter, desugar body)
                        | FunS' (name, body) -> Fun
                        | _ -> raise (Interp "desugar - Match Not Found")


(* interp : Value env -> exprC -> value *)
let rec interp env r = match r with
                       | NumC i        -> Num i
                       | BoolC b 	    -> Bool b
                       | IfC (test, option1, option2) ->  let e = interp env test in
                                                          (match e with
                                                          | Bool b -> if b then interp env option1 else interp env option2
                                                          | _  -> raise (Interp "not a bool"))
                       | ArithC (str_operator, val_l, val_r) -> arithEval str_operator (interp env val_l) (interp env val_r)
                       | CompC (str_operator, val_l, val_r) -> compEval str_operator (interp env val_l) (interp env val_r) 
                       | EqC (val_l, val_r) -> eqEval (interp env val_l) (interp env val_r)
                       | VarC k -> (match lookup k env with
                                    | Some v -> v
                                    | None -> raise (Interp "no variable"))
                       | LetC (var, expr1, expr2) -> interp (bind var (interp env expr1) env) expr2
                       | ListC list_val 	-> List (List.map (interp env) list_val)
                       | TupC list_val -> Tup  (List.map (interp env) list_val)
                       (*ISSUES, ISSUES, ISSUES*)
                       | FunC (name, parameters, body) -> let parameters' = interpret parameters env in
                                                              bind name (interpret body env) env
                       | FunC' (name, body) -> bind name (interpret body env) env


(* evaluate : exprC -> val *)
let evaluate exprC = exprC |> interp []

let rec valToString r = 
  let rec list_to_string lst t =
    match t with
    | "list" -> (match lst with
            		| [] -> ""
            		| hd :: [] -> valToString hd
            		| hd :: tl -> (valToString hd ^ " $ " ^ list_to_string tl "list"))
    | _ -> (match lst with
                | [] -> ""
                | hd :: [] -> valToString hd
                | hd :: tl -> (valToString hd ^ ", " ^ list_to_string tl "tup")) in 
  match r with
  | Num i           -> string_of_float i
  | Bool b 			    -> string_of_bool b
  | Tup lst         -> "{" ^ (list_to_string lst "tup") ^ "}"
  | List lst 		    ->  "{^" ^ (list_to_string lst "list") ^ "^}" 
