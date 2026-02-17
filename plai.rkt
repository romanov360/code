#lang plait
;Page 24: following along.
#|
(define-type Exp
  [num (n : Number)]
  [plus (left : Exp) (right : Exp)])
|#

;Page 33 Do Now 1: try getting the number field from non-number S-Exps, etc.
;(s-exp->list `{+ 1 2}) ;This is the working one
;(s-exp->number `{+ 1 2})
;Says "not a number"
;(s-exp->list `1)
;Says "not a list"
;(s-exp->number `+)
;Says "not a number"
;(s-exp->number 1)
;Says "typecheck failed: S-Exp vs. Number

;Page 33 Do Now 2: think about what type we want for our parser.
;We want the output of our parser to be an AST, represented by
;the type Exp. The input should be an S-Exp, like `1, or `{+ 1 {+ 2 3}}.

;Page 34 following along.
#|
(define (parse s)
  (cond
    [(s-exp-number? s)
     (num (s-exp->number s))]
    [(s-exp-list? s)
     (let ([l (s-exp->list s)])
       (if (symbol=? '+
                     (s-exp->symbol (first l)))
         (plus (parse (second l)) (parse (third l)))
         (error 'parse "list not an addition")
        )
      )
     ]
    ))
|#

;I mistook ` for ', what is the difference? Code only has 's, and literals
;only have `s, but why?

;Page 35 Do Now: any missing tests for the parser?
;Put in a non-plus list, a non-S-Exp, a plus-list with one or zero following
;numbers, a plus-list with a non-number in the first or second element.
;Though these would all error out, and I don't know `test` syntax enough
;to check whether an error is thrown. Let's try anyway.
;(test (parse `{0 1 2}) (error 'parse "list not an addition"))
;That didn't work, it threw an error during the test instead.

;(test/exn (parse `{1 + 2}) "")
;given: "s-exp->symbol: not a symbol: `1". Right, so this breaks at Racket
;conversion from text to S-Exp, so this is not a problem with the parser.
;Actually, maybe there is a way to ...
;Actually, it is a problem with the parser, it is doing =? '+, so the error
;occurs when = resolves to equality between symbols, which `1 is not. The
;parser could be improved by checking (s-exp-symbol? (first l)) before
;assuming that the getter works. Ah, that's the actual error source, it's
;the getter s-exp->symbol, on an S-Exp that is not a symbol. Let's try.
;(s-exp-symbol? `1)
;(s-exp-symbol? `+)
;Nice, this is a valid function, like s-exp-number?.
#|
(define (parse1 s)
  (cond
    [(s-exp-number? s)
     (num (s-exp->number s))]
    [(s-exp-list? s)
     (let ([l (s-exp->list s)])
       (
        if
          (s-exp-symbol? (first l))
          (
               if (symbol=? '+
                            (s-exp->symbol (first l)))
                  (plus (parse (second l)) (parse (third l)))
                  (error 'parse "list not an addition")
           )
          (error 'parse "element 0 is not a symbol")
        )
      )
     ]
    ))
|#
;(test/exn (parse1 `{1 + 2}) "element 0 is not a symbol")
;Sweet, it passed.

;Exercise p. 44: Q: why delegate + type checkking to a helper, not calc?
;A: you could inline the helper. Breaking it out gives the usual pros of
;modularization, we know the explanation. Here, let me try to inline it.
;DrRacket tip: Alt+(, Alt+[, Alt+{.
#|
(define-type Exp
  [numE (n : Number)]
  [boolE (b : Boolean)]
  [plusE (left : Exp) (right : Exp)]
  ;[cndE (test : Exp) (then : Exp) (else : Exp)]
  ;Take out cndE for this exercise.
  )
(define-type Value
  [numV (n : Number)]
  [boolV (b : Boolean)]
  )
(calc : (Exp -> Value))
(define (calc e)
  (type-case Exp e
    [(numE n) (numV n)]
    [(boolE n) (boolV n)]
    [(plusE l r) (add (calc l) (calc r))]
    )
  )
|#
;(add : )
;Don't know syntax for function of two arguments. Curried?
;No, but this helped: https://www.reddit.com/r/Racket/comments/x64395/typed_racket_how_to_type_annotate_a_function_that/
#|
(add : (Value Value -> Value))
(define (add v1 v2)
  (type-case Value v1
    [(numV n1)
     (type-case Value v2
       [(numV n2) (numV (+ n1 n2))]
       [else (error '+ "expects RHS to be a num")])]
    [else (error '+ "expects LHS to be a num")]
    )
  )
|#
;Now try to inline.
;Well, can't substitute the function body in for (add .. ..), since
;you need to call calc on the Exps first to turn them into Values.
#|
(calc : (Exp -> Value))
(define (calc1 e)
  (type-case Exp e
    [(numE n) (numV n)]
    [(boolE n) (boolV n)]
    [(plusE l r)
     (type-case Value (calc l)
    [(numV n1)
     (type-case Value (calc r)
       [(numV n2) (numV (+ n1 n2))]
       [else (error '+ "expects RHS to be a num")])]
    [else (error '+ "expects LHS to be a num")]
    )
     ]
    )
  )
|#
;Another DrRacket tip: Alt+) to get to closing paren.
#|
(test/exn (calc (plusE (numE 0.1) (boolE #true))) "expects RHS to be a num")
(test/exn (calc (plusE (boolE #false) (boolE #true))) "expects LHS to be a num")
(test (calc (plusE (numE 2) (numE 1))) (numV 3))
|#
;Nice, it worked.

;Pro Tip p. 44: test calc. plusE already tested for valid and invalid branches
;above.
#|
(test (calc (numE 3)) (numV 3))
(test (calc (boolE #true)) (boolV #true))
|#

;Do Now p.48: why are the let1 examples like {let1 {x 1} {+ x x}} not legal?
;Not sure, they look fine.
;Now I looked at the answer. I didn't notice the last "x", but I thought that
;the other programs were fine. E.g. the one above would have parse tree
;<expr>
;  |
;{let1 {<var> <expr>} <expr>}
;  |
;{let1 {x <num>} <expr>}
;...
;Oh that's the problem, the <expr> on the right needs to become x:<var>
;Got it.

;Do Now p. 49: come up with an expr that let1s one var twice and uses both.
;Isn't the example on p. 48 valid?
;{let1 {x 1}
;  {+ {let1 {x 2} x}
;  x}}
;I think this would be 1+2=3.

;What is Symbol on page 53?
;Exercise 1 p. 56: what if one did not pass in the interpreted value into
;the extend call?
;A: extend's third argument is a Value, so if it got called with val instead
;of interp val nv, that would have been a type error, since val:Exp. Now,
;what if extend:(Env Symbol Exp -> Env)? Then, calling it with val:Exp would
;result in that expression being interpreted all the way to a Value each time
;it is referred to. That is why this chapter is called caching local binding.
;Exercise 2 p. 56: what if you interpreted the body with the old environment?
;A: extending the environment would have no effect. Only the old bindings
;would exist.
;Exercise 3 p. 56: what else is wrong with the interpreter?
;A: yes, n is not of type Value, it is of type Num. You would need to do
;(NumV num), as in the boolean interpreter. The other branches have this
;issue, too.
;Exercise 4 p. 56: is it OK that we do not remove bindings from environments?
;A: it's fine. extend is pure, so even if a deeper local binding shadows a
;shallower one, this will not affect the environment in which the more
;shallowly bound variable is evaluated.

;Exercise p. 57: what considerations are there when extending single-
;argument functions to multiple arguments?
;A: One consideration is evaluation order. I think in C, there is no
;guarantee about the evaluation order of the arguments passed to a
;function. This is semantically different from left-to-right
;evaluation of arguments before they are passed to a function.

;Do Now p. 58: to add functions, how many new Type-Cases need to be added
;to the abstract syntax?
;A: functions are defined, locally bound, and called. Local binding is
;already accomplished by let1E, so two constructs need to be added. varE
;in its current form cannot support getting the value of a function,  it would
;need to have one more parameter, which is the function to apply to the
;arguments in an environment.

;Do Now p. 59: what should \x->x+x evaluate to? Hint: think in terms of types.
;A: right now Value is either numV or booleanV, so we don't have a suitable
;Type-Case for what this program would evaluate to. Thinking in terms of types,
;we would like it to evaluate to type-case of Value that represents it being
;numV->numV. That would help programs composable. I'm not sure there is a
;way to extend Value to make it support arbitrary function types, though.

;Exercise p.62: do other languages evaluate the function or body first?
;A: in Haskell, this program:
#|
main = do
  let a=5
  a undefined
|#
;gives this error:
;No instance for ‘Num (t0 -> IO ())’ arising from the literal ‘5’
;which means that it type-checked the function before it evaluated the
;argument. Otherwise, it would have given a Prelude.undefined error.
;However, in Python:
#|
>>> a=5
>>> a(1/0)
ZeroDivisionError: division by zero 
|#
;Then, Python evaluated the argument before it type-checked the function.
;This is opposite of what Haskell did, but like what plait would do.

;Exercise p. 65: run static/dynamic scope example in Stacker.
#|
(let ([x 1])
  (let ([f (lambda (y) x)])
    (let ([x 2])
      (f 10))))
It evaluates to 1. My favorite part was that there were two environments that
extended the let x=1 environment, which was the let inside it, and the
environment that calling f produced. That showed why x=1 in that environment.
|#

#|
Exercise p. 67: the function and argument expressions are evaluated with the
dynamic closure, not the function's closure. Is that right?
A: argument expressions should be evaluated with the dynamic closure, since you
want to be able to bind new variables after defining the function, and pass them
into the function as arguments, which would give an error if using the
function's closure. As for the function expression, it doesn't matter which
closure is used, since a funV is made from a lamE without respect to the
environment, and the contents of the environment cannot change the type-case of
the expression to or from lamE.
|#

;Do now p. 67: what should this produce?
#|
((let ([x 3])
   (lambda (y) (+ x y)))
 4)
|#
;A: I think it will produce 7. Elimination turns it into:
;((lambda (y) (+ 3 y)) 4), which morally should substitute into
;(+ 3 4) which is 7.

;Exercise p. 68: what should this produce? What does it produce in plait?
((let ([y 3])
   (lambda (y) (+ y 1)))
 5)
;I think it should produce 6 in Racket. Somehow, substitution stops when it
;sees the closure's formal parameter is the symbol being substituted.
;In plait, it is:
