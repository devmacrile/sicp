(define (squarer a b)
    (multiplier a a b))

; First, there are not any constraints on the value
; of b (i.e. nonnegative).  Second, the (process-new-value)
; procedure contains control flow logic that expects at least
; a pair of m1, m2, product to have a value.