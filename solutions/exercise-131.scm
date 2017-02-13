; (a)
(define (product term a next b)
    (define (iter a result)
        (if (> a b) result
            (iter (next a) (* result (term a)))))
    (iter a 1))

(define (identity x) x)
(define (cube x) (* x x x))
(define (inc x) (+ x 1))

(product identity 1 inc 5)
(product cube 3 inc 5)


; (b)
; Solution to (a) was iterative, so write a recursive version
(define (recursive-product term a next b)
    (if (> a b)
        1)
    (* (term a) 
        (product term (next a) next b)))

(recursive-product identity 1 inc 5)
(recursive-product cube 3 inc 5)
