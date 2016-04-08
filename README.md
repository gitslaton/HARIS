# HARIS
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
Start utop
Enter: 
`#load "types.cmo";;`
Enter:
`#use "tests.ml";;`


[types.ml](https://github.com/gitslaton/HARIS/blob/master/types.ml)

[types.mli](https://github.com/gitslaton/HARIS/blob/master/types.mli)

[lexer](https://github.com/gitslaton/HARIS/blob/master/lexer.mll)

[parser](https://github.com/gitslaton/HARIS/blob/master/parser.mly)
