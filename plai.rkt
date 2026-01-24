#lang plait
;Page 24: following along.
(define-type Exp
  [num (n : Number)]
  [plus (left : Exp) (right : Exp)])

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
;the getter s-exp->symbol, on an S-Exp that is not a symbol.

