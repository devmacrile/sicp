(define (count-pairs x)
    (if (not (pair? x))
        0
        (+ (count-pairs (car x))
            (count-pairs (cdr x))
            1)))

; return 3
(define x (cons `a (cons `b (cons `c `d))))
(count-pairs x)

; return 4
(define x1 (cons `a `b))
(define x2 (cons x1 `c))
(count-pairs (cons x1 x2))

; return 7
(define x1 (cons `a `b))
(define x2 (cons x1 x1))
(count-pairs (cons x2 x2))

; does not return (taking make-cycle from 3.13)
(define (make-cycle x)
    (set-cdr! (last-pair x) x)
    x)

(define z (make-cycle (cons `a (cons `b (cons `c `d)))))
(count-pairs z) 
