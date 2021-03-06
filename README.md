# HARIS
## "Handy And Radically Impressive Syntax"
Programming Languages Final Project

To compile:

```terminal
ocamlyacc parser.mly
ocamllex lexer.mll
ocamlc -c types.mli parser.mli lexer.ml parser.ml types.ml driver.ml
ocamlc -o lang lexer.cmo parser.cmo types.cmo driver.cmo
./lang
``` 

You can use it interactively as above. Or you can write a "program" in any file, then run it as input to the interpreter by:

`./lang < sample_input.txt`

It is worth it to write some sample programs as you go by and load them that way, for quick testing of your lexer and parser.


To run the interpreter tests:

`ocamlc -c types.mli parser.mli lexer.ml parser.ml types.ml driver.ml`

Start utop and enter
```utop 
#load "types.cmo";;
#use "tests.ml";;
```

#### Important files 

[types.ml](https://github.com/gitslaton/HARIS/blob/master/types.ml):  File that contains all of the types for HARIS.

[types.mli](https://github.com/gitslaton/HARIS/blob/master/types.mli):  Interface file for types.ml

[lexer](https://github.com/gitslaton/HARIS/blob/master/lexer.mll): Defines expressions for tokens defined in the parser.mly.

[details](https://github.com/gitslaton/HARIS/blob/master/details.md): File that contains issues and processes of conquering them.

[examples](https://github.com/gitslaton/HARIS/blob/master/examples): Shows examples of HARIS style programming.

[semantics](https://github.com/gitslaton/HARIS/blob/master/semantics.md): Shows syntax for HARIS.

[tests](https://github.com/gitslaton/HARIS/blob/master/tests.ml): Tests for HARIS.

[parser](https://github.com/gitslaton/HARIS/blob/master/parser.mly): File that defines tokens and procedures.
