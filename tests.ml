open Types

(* You can test expressions of type resultS or resultC and how they are evaluated *)
(* These will only work once you have compiled types.ml *)

(* This is the one kind of test you can write. *)
let t0a = evaluate (NumC 2.3) = Num 2.3

(* You can also use interp directly to specify a custom environment. *)
let t0b = let env1 = bind "x" (Num 3.1) empty
          in interp env1 (NumC 2.3) = Num 2.3

(* You can also test desugar to make sure it behaves properly. *)
let t0c = desugar (NumS 2.3) = NumC 2.3

(* Or you can combine with evaluate to get to the final value. *)
let t0d = evaluate (desugar (NumS 2.3)) = Num 2.3


(*BOOLEAN TESTS*)
let t1a0 = evaluate (BoolC true) = Bool true 
let t1a1 = evaluate (BoolC false) = Bool false 
let t1c0 = desugar (BoolS true) = BoolC true 
let t1c1 = desugar (BoolS false) = BoolC false 
let t1d0 = evaluate (desugar (BoolS true)) = Bool true 
let t1d1 = evaluate (desugar (BoolS false)) = Bool false 


(*CONDITIONAL TESTS*)
let t2a = evaluate (IfC (BoolC true, NumC 2.3, NumC 4.3)) = Num 2.3 
let t2b = evaluate (IfC (BoolC false, NumC 2.3, NumC 4.3)) = Num 4.3 
let t2c = evaluate (IfC (BoolC true, (IfC (BoolC false, NumC 2.3, NumC 4.3)), NumC 7.3)) = Num 4.3 
let t2d = evaluate (IfC (BoolC false, (IfC (BoolC false, NumC 2.3, NumC 4.3)), NumC 7.3)) = Num 7.3 

let t3a = evaluate (desugar (NotS (BoolS true))) = Bool false 
let t3b = evaluate (desugar (NotS (BoolS false))) = Bool true 
let t3c = evaluate (desugar (NotS (IfS (BoolS true, BoolS true, BoolS false)))) = Bool false
let t3d = evaluate (desugar (NotS (IfS (BoolS false, BoolS true, BoolS false)))) = Bool true

let t4a = evaluate (desugar (OrS (BoolS true, BoolS true))) = Bool true 
let t4b = evaluate (desugar (OrS (BoolS false, BoolS true))) = Bool true 
let t4c = evaluate (desugar (OrS (BoolS true, BoolS false))) = Bool true 
let t4d = evaluate (desugar (OrS (BoolS false, BoolS false))) = Bool false 

let t5a = evaluate (desugar (AndS (BoolS true, BoolS true))) = Bool true 
let t5b = evaluate (desugar (AndS (BoolS true, BoolS false))) = Bool false 
let t5c = evaluate (desugar (AndS (BoolS false, BoolS true))) = Bool false 
let t5d = evaluate (desugar (AndS (BoolS false, BoolS false))) = Bool false 


(*ARITHMETIC OPERATORS TESTS*)
let t6e = evaluate (IfC (BoolC true, 
						 ArithC ("+", NumC 5.0, NumC 5.0), 
						 ArithC ("-", NumC 5.0, NumC 5.0))) = Num 10.0 
let t6f = evaluate (IfC (BoolC false, 
						 ArithC ("+", NumC 5.0, NumC 5.0), 
						 ArithC ("-", NumC 5.0, NumC 5.0))) = Num 0.0 
let t6g = evaluate (IfC (BoolC true, 
						 ArithC ("/", NumC 5.0, NumC 5.0), 
						 ArithC ("*", NumC 5.0, NumC 5.0))) = Num 1.0 
let t6h = evaluate (IfC (BoolC false, 
						 ArithC ("/", NumC 5.0, NumC 5.0), 
						 ArithC ("*", NumC 5.0, NumC 5.0))) = Num 25.0
let t6i = evaluate (desugar (IfS (BoolS false, 
						 	 	  ArithS ("/", NumS 5.0, NumS 5.0), 
						 		  ArithS ("*", NumS 5.0, NumS 5.0)))) = Num 25.0 


(*COMPARISON OPERATORS TESTS*)
let t7e = evaluate (IfC (BoolC true, 
						 CompC (">", NumC 5.0, NumC 5.0), 
						 CompC (">=", NumC 5.0, NumC 5.0))) = Bool false 
let t7f = evaluate (IfC (BoolC false, 
						 CompC (">", NumC 5.0, NumC 5.0), 
						 CompC (">=", NumC 5.0, NumC 5.0))) = Bool true 
let t7g = evaluate (IfC (BoolC true, 
						 CompC ("<", NumC 5.0, NumC 5.0), 
						 CompC ("<=", NumC 5.0, NumC 5.0))) = Bool false 
let t7h = evaluate (IfC (BoolC false, 
						 CompC ("<", NumC 5.0, NumC 5.0), 
						 CompC ("<=", NumC 5.0, NumC 5.0))) = Bool true 
let t7e = evaluate (desugar (IfS (BoolS true, 
						 		  CompS (">", NumS 5.0, NumS 5.0), 
						 		  CompS (">=", NumS 5.0, NumS 5.0)))) = Bool false 


(*EQUALITY TESTS*)
let t8e = evaluate (EqC (NumC 5.0, NumC 5.0)) = Bool true
let t8f = evaluate (EqC (NumC 5.0, NumC 4.0)) = Bool false
let t8g = evaluate (desugar (EqS (NumS 5.0, NumS 5.0))) = Bool true
let t8h = evaluate (desugar (EqS (NumS 5.0, NumS 4.0))) = Bool false
let t8i = evaluate (desugar (NeqS (NumS 5.0, NumS 5.0))) = Bool false
let t8j = evaluate (desugar (NeqS (NumS 5.0, NumS 4.0))) = Bool true

(*TUP TESTS*)
let t9a = evaluate (TupC (NumC 1.0, BoolC true)) = Tup (Num 1.0, Bool true)

(*LIST TESTS*)
let t10a = evaluate (^10 $ 10^)
