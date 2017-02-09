(define (sum term a next b)
    (define (iter a result)
        (if (> a b) result
            (iter (next a) (+ result (term a)))))
    (iter a 0))

(define (identity x) x)
(define (cube x) (* x x x))
(define (inc x) (+ x 1))

(sum identity 0 inc 10)
(sum cube 0 inc 10)