(define (f g)
    (g 2))

(define (square x) (* x x))

(f square)
(f f)  ; The object 2 is not applicable.

; My hypothesis would have been a recursion depth limit.
; But above error is issued.
; (f f) -> (f 2) -> (2 2) => above error
