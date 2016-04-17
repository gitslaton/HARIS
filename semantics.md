# HARIS
## "Handy And Radically Impressive Syntax"

### Primitives ###

**Types**
HARIS has two primitive types: NUM, BOOL. 
* NUM are numbers expressed as decimals (e.g. 1., 1.1). 
* BOOL is true (or #t) or false (#f).

**Operators**
HARIS has all basic arithmetic, boolean, comparison, and equality operators.
* Arithmetic
  * +, -, *, /
  * Takes two NUM expressions and returns another NUM expression that is the result of performing the arithmetic expression.
* Boolean
  * AND, &&, OR ||
  * Takes two BOOL expressions and returns another BOOL expression based upon the boolean comparison operator used.
* Comparison & Equality
  * <, <=, =>, >, ==, !=
  * Takes two NUM expressions and returns a BOOL expression that is the result of performing the comparison between the two NUM expressions.


### If Statements ###
If statments are performed in the following manner:
```
IF expr1 THEN expr2 ELSE expr3
```
* expr1 must be a BOOL expression
* expr2 and expr3 must be of the same type


### Tuples ###
Tuples are pairs of two or more elements. The elements do not have to be of the same type.
Tuples are contained by curly braces, `{ }`, and individual elements within a tuple are separated by commas, `,`, like the following example:
```
{true, 1.0, false}
```

### Lists ###
Lists are sequences of elements. All elements within the list have to be of the same type. 
Lists are contained by the curly braces, `{ }`, and the carrot symbol, `^`, combined, as in `{^ ^}`. Individual elements within a list are separated by the dollar symbol, `$`, like the following example:
```
{^ 1. $ 1.5 $ 2. ^}
```

####List Functions####
HARIS has four built-in list functions to help work with and change lists. To access these functions, simply have a list, put `.` and the name of the function you're wanting to use after it.
* `EMPTY`
 * Parameters: list
 * Returns true if the list is empty or null and false if the opposite
* `HEAD
 * Returns the first element (or head) of the list
* `TAIL`
 * Returns the last element (or tail) of the list
* `PREPEND`
 * Returns the list with an element prepended to the front of the list

Prepend is a bit different. The following is an example of the proper syntax:

```
{^1 $ 2 $ 3^}.PREPEND.element
```
`element` is the element you wish to prepend to the beginning of the list.


### Functions ###
Functions in HARIS are declared in the following manner:
```
[SKIADAS function_name [function_inputs] =
  [function_body]
]
```
A function is contained by brackets, `[ ]`. The keywork `SKIADAS` is first within the brackets followed by a function name (expressed as `function_name` in the example). Two sets of brackets follow: the first set for parameters, or the function inputs (expressed as `function_inputs` in the example), and the second set for the body of the function (expressed as `function_body` in the example). Recursion is allowed without any syntactic changes.
* A function does not have to have any parameters. In this case, a function declaration would look like the following example:
```
[SKIADAS function_name =
  [function_body]
]
```
####Calling a Function####
Calling a function is done in the following manner:
```
function_name [function_inputs]
```
You do not need the keyword `SKIADAS` to call a function.

### Let Statements ###
Let statements allow a user to have run an expression, `expr1`, and have the result of that expression used when running another expression, `expr2`. Let statements in HARIS look like the following:

```
LET expr1 IN expr2

LET expr1 IN
  expr2
```

### Comments ###
Commenting in HARIS uses the combination of the `+` symbol and the `-` symbol, creating `+-`. To end a comment, whether on one or multiple lines, use the reverse, as in `-+`.
The following is an example:
```
+-This is a single line comment.-+

+-
This is a
multiple line
comment.
-+
```
Comments can contain any lowercase or uppercase letters (e.g. `a` or `A`), numbers, underscores (e.g. `_`), or whitespace.
