(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

; test
(= (a-plus-abs-b 1 -1) (a-plus-abs-b 1 1))

; The result of the the 'if' statement is an operator
; So => an operator can be a compound expression.
