exception Desugar of string      (* Used for desugarer errors *)
exception Interp of string       (* Used for interpreter errors *)
exception Lists of string        (* Used for list function errors *)
exception Typecheck of string 

type typeT = NumT 
           | BoolT 
           | TupT of typeT list
           | ListT of typeT
           | ClosureT  
           | AnyT 
           | FunT of typeT * typeT

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
           | GLetS of string * exprS 
           | LetS of string * exprS * exprS
           | ListS of exprS list
           | FunS of string * string * typeT * exprS * typeT
           | FunS2 of string * typeT * exprS * typeT
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
           | GLetC of string * exprC 
           | LetC of string * exprC * exprC
           | ListC of exprC list
           | FunC of string * string * typeT * exprC * typeT
           | FunC2 of string * typeT * exprC * typeT
           | CallC of exprC * exprC
           | HeadC of exprC 
           | TailC of exprC 
           | ListElC of exprC * exprC 
           | ListEmC of exprC
           | ListPrepC of exprC * exprC 
           | TupCarC of exprC
           | TupCdrC of exprC

type 'a env = (string * 'a) list

type value = Num of float 
           | Bool of bool 
           | Tup of value list
           | List of value list 
           | Closure of value env * exprC


let empty = [] 

let global_env = ref [] 

let global_static_env = ref [] 


(* lookup : string -> 'a env -> 'a option *)
let rec lookup str env = match env with
  | []          -> None
  | (s,v) :: tl -> if s = str then Some v else lookup str tl 

(* val bind :  string -> 'a -> 'a env -> 'a env *)
let bind str v env = (str, v) :: env



(*LIST THINGS -> PREPEND/EMPTY//GETTING HEAD/GETTING TAIL*)
(**)
let prepend lst element = 
  match lst with 
  | List l -> List (element :: l)
  | _ -> raise (Lists "Cannot prepend on non-list")

    
let test_empty lst =
  match lst with 
  | List [] -> Bool true
  | List lst' -> Bool false
  | _ -> raise (Lists "Cannot check if empty on non-list")

let lst_head lst = 
    match lst with 
    | List [] -> raise (Lists "list is empty") 
    | List (element :: rest) -> element
    | _ -> raise (Lists "Cannot get head on non-list") 
    
let rec lst_tail lst = 
    match lst with
    | List [] -> raise (Lists "list is empty")
    | List (element :: rest) -> List rest
    | _ -> raise (Lists "Cannot get tail on non-list")

let rec lst_num lst num =
    match (lst, num) with 
    | (List [], _) -> raise (Lists "list out of bounds")
    | (List (element :: rest), Num num') -> if num' = 0.0
                                            then element 
                                            else lst_num (List rest) (Num (num' -. 1.0))
    | _ -> raise (Lists "Function called on non-list")
                                       

(*TUPLE THINGS -> CAR/CDR*)
(**)

let lst_car lst = 
    match lst with 
    | Tup [] -> raise (Lists "Tup is empty") 
    | Tup (element :: rest) -> element
    | _ -> raise (Lists "Cannot get car on non-tup") 
    

let lst_cdr lst = 
    match lst with
    | Tup [] -> raise (Lists "list is empty")
    | Tup (element :: []) -> raise (Lists "Cannot call cdr on 1 element tuple")
    | Tup (element :: rest) -> Tup rest
    | _ -> raise (Lists "Cannot get tail on non-list")
(**)


(*MAP/FILTER/FOLDR/FOLDL*)
(*
let rec map fun_x lst = 
    match lst with
    | [] -> []
    | element :: rest -> fun_x element :: map fun_x rest

let rec filter fun_bool lst = 
    match lst with
    | [] -> []
    | element :: rest -> (match fun_bool element with
                          | true -> element :: filter fun_bool rest
                          | false -> filter fun_bool rest)

let rec foldr fun_a_b lst x = 
    match lst with
    | [] -> x
    | element :: rest -> fun_a_b element (foldr fun_a_b rest x)

let rec foldl fun_a_b x lst = 
    match lst with
    | [] -> x
    | element :: rest -> foldl fun_a_b (fun_a_b x element) rest
*)

(*HELPER FUNCTIONS*)
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

let eqEval val_l val_r = 
  match (val_l, val_r) with 
  | (Num val_l', Num val_r') -> Bool (val_l' = val_r')
  | (Bool val_l', Bool val_r') -> Bool (val_l' = val_r')
  | _ -> Bool false 



(* INTERPRETER *)
(* desugar : exprS -> exprC *)
let rec desugar exprS = 
  match exprS with
  | NumS i -> NumC i
  | BoolS b -> BoolC b
  | IfS (test, option1, option2) -> IfC (desugar test, desugar option1, desugar option2) 
  | NotS n -> IfC (desugar n, BoolC false, BoolC true) 
  | OrS (o1, o2) -> IfC (desugar o1, BoolC true, IfC (desugar o2, BoolC true, BoolC false)) 
  | AndS (a1, a2) -> IfC (desugar a1, IfC (desugar a2, BoolC true, BoolC false), BoolC false) 
  | ArithS (str_operator, val_l, val_r) -> ArithC (str_operator, desugar val_l, desugar val_r) 
  | CompS (str_operator, val_l, val_r) -> CompC (str_operator, desugar val_l, desugar val_r) 
  | EqS (val_l, val_r) -> EqC (desugar val_l, desugar val_r) 
  | NeqS (val_l, val_r) -> desugar (NotS (EqS (val_l, val_r)))
  | ListS list_val -> ListC (List.map desugar list_val)
  | GLetS (var, expr1) -> GLetC (var, desugar expr1)
  | LetS (var, expr1, expr2) -> LetC (var, desugar expr1, desugar expr2)
  | TupS list_val -> TupC (List.map desugar list_val)
  | FunS (name, parameter, paraT, body, bodyT) -> FunC (name, parameter, paraT, desugar body, bodyT)
  | FunS2 (parameter, paraT, body, bodyT) -> FunC2 (parameter, paraT, desugar body, bodyT)
  | CallS (on_fun, arg) -> CallC (desugar on_fun, desugar arg)
  | VarS k -> VarC k
  | HeadS lst -> HeadC (desugar lst)
  | TailS lst -> TailC (desugar lst)
  | ListElS (lst, n) -> ListElC (desugar lst, desugar n) 
  | ListEmS (lst) -> ListEmC (desugar lst)
  | ListPrepS (lst, element) -> ListPrepC (desugar lst, desugar element)
  | TupCarS lst -> TupCarC (desugar lst)
  | TupCdrS lst -> TupCdrC (desugar lst)
  | _ -> raise (Interp "desugar - Match Not Found")



(* interp : Value env -> exprC -> value *)
let rec interp env r = 
  match r with
  | NumC i        -> Num i
  | BoolC b 	    -> Bool b
  | IfC (test, option1, option2) ->  let e = interp env test in
                                       (match e with
                                        | Bool b -> if b then interp env option1 else interp env option2
                                        | _  -> raise (Interp "not a bool"))
  | ArithC (str_operator, val_l, val_r) -> arithEval str_operator (interp env val_l) (interp env val_r)
  | CompC (str_operator, val_l, val_r) -> compEval str_operator (interp env val_l) (interp env val_r) 
  | EqC (val_l, val_r) -> eqEval (interp env val_l) (interp env val_r)
  | ListC list_val  -> List (List.map (interp env) list_val)
  | GLetC (var, expr1) -> let x = interp env expr1 in
                             (global_env := bind var x env; x)
  | LetC (var, expr1, expr2) -> interp (bind var (interp env expr1) env) expr2
  | TupC list_val -> Tup (List.map (interp env) list_val)    
  | FunC (fun_name, parameter, paraT, body, bodyT) -> Closure (env, r)
  | FunC2 (parameter, paraT, body, bodyT) -> Closure (env, r)
  | CallC (on_fun, arg) -> let c = interp env on_fun in
                             let v = interp env arg in 
                               (match c with
                                | Closure (env', FunC (name, para, paraT, body, bodyT)) -> interp (bind name c (bind para v env')) body
                                | Closure (env', FunC2 (para, paraT, body, bodyT)) -> interp (bind para v env') body
                                | _ -> raise (Interp "Cannot run on non-closure"))
  |  VarC k -> (match lookup k env with 
                | Some v -> v
                | None -> raise (Interp "No matching variable found"))
  | HeadC lst -> lst_head (interp env lst)
  | TailC lst -> lst_tail (interp env lst)
  | ListElC (lst, n) -> lst_num (interp env lst) (interp env n)
  | ListEmC lst -> test_empty (interp env lst)
  | ListPrepC (lst, element) -> prepend (interp env lst) (interp env element)
  | TupCarC lst -> lst_car (interp env lst)
  | TupCdrC lst -> let c = lst_cdr (interp env lst) in
                   (match c with
                   | Tup (ele::[]) -> ele
                   | _ -> c)
  | _ -> raise (Interp "interp - Match Not Found")                



(*TYPECHECKING*)
let rec typecheck env ty =
 let rec typecheck_list env lst init =
   (match lst with
    | [] -> init
    | hd :: tl -> if (typecheck env hd) = init
                  then typecheck_list env tl init
                  else raise (Typecheck "All values in list must have same type")) 
  in match ty with
     | NumC i -> NumT
     | BoolC b -> BoolT
     | IfC (test, option1, option2) -> if typecheck env test = BoolT
                                       then let t1 =  typecheck env option1 in
                                            let t2 = typecheck env option2 in
                                            if t1 = t2
                                            then t1
                                            else raise (Typecheck "If statement: then statement does not have same type as else")
                                       else raise (Typecheck "If statement: test is not a boolean")
     | ArithC (str_operator, val_l, val_r) -> if typecheck env val_l = NumT && typecheck env val_r = NumT
                                             then NumT
                                             else raise (Typecheck "Cannot do arithmetic on non-Num")
     | CompC (str_operator, val_l, val_r) -> if typecheck env val_l = NumT && typecheck env val_r = NumT
                                             then BoolT
                                             else raise (Typecheck "Cannot do comparison on non-Num")
     | EqC (val_l, val_r) -> let (t1, t2) = (typecheck env val_l, typecheck env val_r) in
                             (match (t1, t2) with
                              | (NumT, NumT) -> BoolT
                              | (BoolT, BoolT) -> BoolT
                              | _ -> raise (Typecheck "Cannot do equality comparison on different types"))
     | ListC list_val -> (match list_val with
                          | [] -> ListT AnyT
                          | element :: [] -> ListT (typecheck env element)
                          | element :: rest -> ListT (typecheck_list env rest (typecheck env element)))
     | LetC (var, expr1, expr2) -> typecheck (bind var (typecheck env expr1) env) expr2
     | GLetC (var, expr1) -> let t = typecheck env expr1 in
                                 (global_static_env := bind var t env; t)
     | TupC list_val -> (match list_val with
                         | [] -> TupT [AnyT] 
                         | _ -> TupT (List.fold_right (fun x acc -> (typecheck env x :: acc)) list_val []))
     | FunC (fun_name, parameter, paraT, body, bodyT) -> let returnT = typecheck (bind fun_name paraT (bind parameter paraT env)) body in
                                                         if returnT = bodyT
                                                         then FunT (paraT, bodyT)
                                                         else raise (Typecheck "Suggested return type does not match actual body type")
     | FunC2 (parameter, paraT, body, bodyT) -> if typecheck (bind parameter paraT env) body = bodyT
                                                then FunT (paraT, bodyT)
                                                else raise (Typecheck "Suggested return type does not match actual body type")
     | CallC (on_fun, arg) -> (match typecheck env on_fun with
                               | FunT (t1, t2) -> if t1 = typecheck env arg
                                                  then  t2
                                                  else raise (Typecheck "Argument type does not match function's expected type")
                               | AnyT -> AnyT
                               | ListT AnyT -> AnyT
                               | TupT [AnyT] -> AnyT
                               | _ -> raise (Typecheck "Calling non-function"))
     | VarC k -> (match lookup k env with
                  | Some v -> v
                  | None -> raise (Typecheck "no matching variable found"))
     | HeadC lst -> (match typecheck env lst with
                     | ListT t -> t
                     | _ -> raise (Typecheck "Cannot call HEAD on non-list"))
     | TailC lst -> (match typecheck env lst with
                     | ListT t -> ListT t
                     | _ -> raise (Typecheck "Cannot call TAIL on non-list"))
     | ListElC (lst, n) -> (match (typecheck env lst, typecheck env n) with
                            | (t1, NumT) -> t1
                            | _ -> raise (Typecheck "Given non-num for indexing"))
     | ListEmC (lst) -> (match typecheck env lst with
                         | ListT _  -> BoolT
                         | TupT [AnyT] -> BoolT
                         | _ -> raise (Typecheck "Invalid argument"))
     | ListPrepC (lst, element) -> if typecheck env lst = typecheck env element
                                   then typecheck env element
                                   else raise (Typecheck "Cannot prepend onto list of different value type")
     | TupCarC lst -> (match typecheck env lst with
                       | TupT (hd :: tl) -> hd
                       | TupT []  -> AnyT
                       | _ -> raise (Typecheck "Cannot call CAR on non-list"))
     | TupCdrC lst -> (match typecheck env lst with
                       | TupT (hd::[]) -> hd
                       | TupT (hd::hd'::[]) -> hd'
                       | TupT (hd::tl) -> TupT tl
                       | TupT [] -> TupT [AnyT]
                       | _ -> raise (Typecheck "Cannot call CDR on non-list"))
     | _ -> raise (Typecheck "typecheck - Match Not Found")                



(* evaluate : exprC -> val *)
let evaluate exprC = let t = typecheck (!global_static_env) exprC in
                        (t, interp (!global_env) exprC)



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
              | hd :: tl -> (valToString hd ^ ", " ^ list_to_string tl "tup")) 
  in match r with
     | Num i           -> string_of_float i ^ "0"
     | Bool b 			    -> string_of_bool b
     | Tup lst         -> "{" ^ (list_to_string lst "tup") ^ "}"
     | List lst 		    ->  "{^" ^ (list_to_string lst "list") ^ "^}" 
     | Closure (e, f)       -> ""
     | _               -> raise (Interp "not valid to express as string")

let rec typeToString r =  
  (match r with
   | NumT -> "NUM" 
   | BoolT -> "BOOL" 
   | TupT lst -> "TUP: " ^ (List.fold_right (fun x acc -> (typeToString x ^ " * " ^ acc)) lst "")
   | ListT lst -> "LIST: " ^ typeToString lst
   | FunT (para, body) -> typeToString para ^ " -> " ^ typeToString body
   | _ -> "TYPE UNKNOWN") 

let typeToCombo (vT, v) = 
  typeToString vT ^ " | " ^ valToString v 