# HARIS
## "Handy And Radically Impressive Syntax"

### Primitives ###

**Types**
HARIS has two primitive types: NUM, BOOL. 
* NUM are numbers expressed as decimals (e.g. 1.0, 1.1). 
* BOOL is true (or #t) or false (#f).

**Operators**
HARIS has all basic arithmetic, boolean, comparison, and equality operators.
* Arithmetic
  * +, -, *, /
  * Takes two NUM expressions and returns another NUM expression that is the result of performing the arithmetic expression.
* Boolean
  * &&, ||
  * Takes two BOOL expressions and returns another BOOL expression.
* Comparison & Equality
  * <, <=, =>, >, ==, !=
  * Takes two NUM expressions and returns a BOOL expression that is the result of performing the comparison between the two NUM expressions.


### If Statements ###
If statments are performed in the following manner:
```
IF expr1 THEN expr2 ELSE expr3
```
* expr1 must be a BOOL expression
* expr2 and expr3 must have the same type


### Tuples ###
Tuples are pairs of two or more elements. The elements do not have to be of the same type.
Tuples are contained by curly braces, `{ }`, and individual elements within a tuple are separated by commas, `,`, like the following example:
```
{true, 1.0, false}
```


### Lists ###
Lists are sequences of elements. They do not all have to have the same type. 
Lists are contained by the carrot symbol, `^`, and individual elements within a list are separated by the dollar symbol, `$`, like the following example:
```
^ 1.0 $ true $ 2.0 ^
```


### Functions ###
Functions in HARIS are declared in the following manner:
```
[skiadas function_name [function_inputs] 
  [function_body
]
```
A function is contained by brackets, `[ ]`. The keywork `skiadas` is within the surrounding brackets followed by a function name (expressed as `function_name` in the example). Two sets of brackets follow, the first for the function inputs (expressed as `function_inputs` in the example) and the second for the body of the function (expressed as `function_body` in the example).
* Recursion is allowed without any syntactic changes.

### Let Statements ###

```
LET expr1 IN expr2

LET expr1 IN
  expr2
```

### Pattern Matching ###
OCAML has a pattern matching mechanism known as the `match` statement. The following is an example:
```
match expr1 in
| expr2 -> expr3
```
HARIS has a `group` statement for pattern matching.
The `group` statement is expressed in the following manner:
```
group (expr1) in
$ (expr2) >> (expr3)
```
The `group`statement matches `expr1`, which must be surrounded by `( )`, with cases listed sequentially (denoted by the `$`), such as `expr2`. Whenever `expr1` matches a case, it runs the code for that case, such as `expr3` in the above example; the `>>` symbols separate the match expression from the expression that needs to be run.


### Comments ###
Commenting in HARIS are declared by the combination of the `+` symbol and the `-` symbol, creating `+-`. To end a comment, whether on one or multiple lines, use the reverse, as in `-+`.
The following is an example:
```
+-This is a single line comment.-+

+-
This is a
multiple line
comment.
-+
```
