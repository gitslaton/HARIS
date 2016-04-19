open Types

(* This is the one kind of test you can write. *)
let t0a = evaluate (NumC 2.3) = (NumT, Num 2.3)

(* You can also use interp directly to specify a custom environment. *)
let t0b = let env1 = bind "x" (Num 3.1) empty
          in interp env1 (NumC 2.3) = Num 2.3

(* You can also test desugar to make sure it behaves properly. *)
let t0c = desugar (NumS 2.3) = NumC 2.3

(* Or you can combine with evaluate to get to the final value. *)
let t0d = evaluate (desugar (NumS 2.3)) = (NumT, Num 2.3)


(*BOOLEAN TESTS*)
let t1a0 = evaluate (BoolC true) = (BoolT, Bool true) 
let t1a1 = evaluate (BoolC false) = (BoolT, Bool false) 
let t1c0 = desugar (BoolS true) = BoolC true 
let t1c1 = desugar (BoolS false) = BoolC false 
let t1d0 = evaluate (desugar (BoolS true)) = (BoolT, Bool true) 
let t1d1 = evaluate (desugar (BoolS false)) = (BoolT, Bool false) 


(*CONDITIONAL TESTS*)
let t2a = evaluate (IfC (BoolC true, NumC 2.3, NumC 4.3)) = (NumT, Num 2.3) 
let t2b = evaluate (IfC (BoolC false, NumC 2.3, NumC 4.3)) = (NumT, Num 4.3) 
let t2c = evaluate (IfC (BoolC true, (IfC (BoolC false, NumC 2.3, NumC 4.3)), NumC 7.3)) = (NumT, Num 4.3) 
let t2d = evaluate (IfC (BoolC false, (IfC (BoolC false, NumC 2.3, NumC 4.3)), NumC 7.3)) = (NumT, Num 7.3)  

let t3a = evaluate (desugar (NotS (BoolS true))) = (BoolT, Bool false) 
let t3b = evaluate (desugar (NotS (BoolS false))) = (BoolT, Bool true)  
let t3c = evaluate (desugar (NotS (IfS (BoolS true, BoolS true, BoolS false)))) = (BoolT, Bool false) 
let t3d = evaluate (desugar (NotS (IfS (BoolS false, BoolS true, BoolS false)))) = (BoolT, Bool true) 

let t4a = evaluate (desugar (OrS (BoolS true, BoolS true))) = (BoolT, Bool true)  
let t4b = evaluate (desugar (OrS (BoolS false, BoolS true))) = (BoolT, Bool true) 
let t4c = evaluate (desugar (OrS (BoolS true, BoolS false))) = (BoolT, Bool true)  
let t4d = evaluate (desugar (OrS (BoolS false, BoolS false))) = (BoolT, Bool false)  
let t5a = evaluate (desugar (AndS (BoolS true, BoolS true))) = (BoolT, Bool true) 
let t5b = evaluate (desugar (AndS (BoolS true, BoolS false))) = (BoolT, Bool false)  
let t5c = evaluate (desugar (AndS (BoolS false, BoolS true))) = (BoolT, Bool false) 
let t5d = evaluate (desugar (AndS (BoolS false, BoolS false))) = (BoolT, Bool false) 


(*ARITHMETIC OPERATORS TESTS*)
let t6e = evaluate (IfC (BoolC true, 
						 ArithC ("+", NumC 5.0, NumC 5.0), 
						 ArithC ("-", NumC 5.0, NumC 5.0))) = (NumT, Num 10.0) 
let t6f = evaluate (IfC (BoolC false, 
						 ArithC ("+", NumC 5.0, NumC 5.0), 
						 ArithC ("-", NumC 5.0, NumC 5.0))) = (NumT, Num 0.0)
let t6g = evaluate (IfC (BoolC true, 
						 ArithC ("/", NumC 5.0, NumC 5.0), 
						 ArithC ("*", NumC 5.0, NumC 5.0))) = (NumT, Num 1.0) 
let t6h = evaluate (IfC (BoolC false, 
						 ArithC ("/", NumC 5.0, NumC 5.0), 
						 ArithC ("*", NumC 5.0, NumC 5.0))) = (NumT, Num 25.0)
let t6i = evaluate (desugar (IfS (BoolS false, 
						 ArithS ("/", NumS 5.0, NumS 5.0), 
						 ArithS ("*", NumS 5.0, NumS 5.0)))) = (NumT, Num 25.0)


(*COMPARISON OPERATORS TESTS*)
let t7e = evaluate (IfC (BoolC true, 
						 CompC (">", NumC 5.0, NumC 5.0), 
						 CompC (">=", NumC 5.0, NumC 5.0))) = (BoolT, Bool false)  
let t7f = evaluate (IfC (BoolC false, 
						 CompC (">", NumC 5.0, NumC 5.0), 
						 CompC (">=", NumC 5.0, NumC 5.0))) = (BoolT, Bool true)  
let t7g = evaluate (IfC (BoolC true, 
						 CompC ("<", NumC 5.0, NumC 5.0), 
						 CompC ("<=", NumC 5.0, NumC 5.0))) = (BoolT, Bool false)  
let t7h = evaluate (IfC (BoolC false, 
						 CompC ("<", NumC 5.0, NumC 5.0), 
						 CompC ("<=", NumC 5.0, NumC 5.0))) = (BoolT, Bool true) 
let t7e = evaluate (desugar (IfS (BoolS true, 
					   CompS (">", NumS 5.0, NumS 5.0), 
						 CompS (">=", NumS 5.0, NumS 5.0)))) = (BoolT, Bool false)  


(*EQUALITY TESTS*)
let t8e = evaluate (EqC (NumC 5.0, NumC 5.0)) = (BoolT, Bool true) 
let t8f = evaluate (EqC (NumC 5.0, NumC 4.0)) = (BoolT, Bool false)
let t8g = evaluate (desugar (EqS (NumS 5.0, NumS 5.0))) = (BoolT, Bool true) 
let t8h = evaluate (desugar (EqS (NumS 5.0, NumS 4.0))) = (BoolT, Bool false)
let t8i = evaluate (desugar (NeqS (NumS 5.0, NumS 5.0))) = (BoolT, Bool false)
let t8j = evaluate (desugar (NeqS (NumS 5.0, NumS 4.0))) = (BoolT, Bool true) 

(*TUP TESTS*)
let t9a = evaluate (TupC ((NumC 1.0) :: (NumC 8.0) :: [])) = (TupT [NumT; NumT], Tup [Num 1.0; Num 8.0]) 
let t9b = evaluate (TupC (NumC 6.0 :: NumC 4.0 :: NumC 7.0 :: [])) = (TupT [NumT; NumT; NumT], Tup [Num 6.0; Num 4.0; Num 7.0])
let t9c = evaluate (TupC (BoolC false :: BoolC true :: BoolC true :: BoolC false :: [])) = (TupT [BoolT; BoolT;BoolT;BoolT], Tup [Bool false; Bool true; Bool true; Bool false])

(*CAR TESTS*)
let t10a = evaluate (TupCarC (TupC (NumC 1.0 :: NumC 8.0 :: []))) = (NumT, Num 1.0)
let t10b = evaluate (TupCarC ((TupC (BoolC false :: BoolC true :: BoolC true :: BoolC false :: [])))) = (BoolT, Bool false)
(*CDR TESTS*)

let t15a = evaluate (TupCdrC (TupC (NumC 1.0 :: NumC 8.0 :: []))) = (NumT, Num 8.0)
let t15b = evaluate (TupCdrC (TupC (BoolC false :: BoolC true :: BoolC true :: BoolC false :: []))) = (TupT [BoolT; BoolT; BoolT], Tup [Bool true; Bool true; Bool false])

(*LIST TESTS*)
let t14a = evaluate (ListC (NumC 1.0 :: NumC 2.0 :: NumC 3.0 :: [])) = (ListT NumT, List [Num 1.0; Num 2.0; Num 3.0])
let t14b = evaluate (ListC (BoolC true :: BoolC false :: [])) = (ListT BoolT, List [Bool true; Bool false])

(*EMPTY TESTS*)
let t16a = evaluate (ListEmC (ListC (NumC 1.0 :: NumC 2.0 :: NumC 3.0 :: []))) = (BoolT, Bool false)
let t16b = evaluate (ListEmC (ListC [])) = (BoolT, Bool true)

(*HEAD TESTS*)
let t17a = evaluate (HeadC (ListC (NumC 1.0 :: NumC 2.0 :: NumC 3.0 :: []))) = (NumT, Num 1.0)
let t17b = evaluate (HeadC (ListC (BoolC true :: []))) =  (BoolT, Bool true)

(*TAIL TESTS*)
let t18a = evaluate (TailC (ListC (NumC 1.0 :: NumC 2.0 :: NumC 3.0 :: []))) = (NumT, Num 3.0)
let t18b = evaluate (TailC (ListC (BoolC true :: []))) = (BoolT, Bool true)

(* LET TESTS *)
let t11a = evaluate (desugar (LetS ("l", BoolS true, (AndS (VarS "l", BoolS true ) )))) = (BoolT, Bool true)
let t11b = evaluate (desugar  (LetS ("b", NumS 2.0, (ArithS ("+", VarS "b", NumS 2.0))))) = (NumT, Num 4.0)

(*FUNC TESTS*)

let t12a = evaluate (desugar (CallS (FunS ("f", "x", NumT, NumS 1.0, NumT), NumS 3.0))) = (NumT, Num 1.0)
let t12b = evaluate (desugar (CallS (FunS ("f", "x", NumT, ArithS ("+", VarS "x", NumS 1.0), NumT), NumS 3.0))) = (NumT, Num 4.0)
let t12c = evaluate (desugar (CallS (FunS ("f", "x", BoolT, EqS (BoolS true, VarS "x"), BoolT), BoolS true))) = (BoolT, Bool true)
let t12d = evaluate (desugar (CallS (FunS ("f", "x", BoolT, EqS (BoolS true, VarS "x"), BoolT), BoolS false))) = (BoolT, Bool false)
let t12e = evaluate (desugar (CallS (FunS ("f", "x", NumT, VarS "x", NumT), NumS 4.0))) = (NumT, Num 4.0)
let t12f = evaluate (desugar (CallS (FunS2 ("t", BoolT, NumS 1.0, NumT), BoolS true))) = (NumT, Num 1.0) 

