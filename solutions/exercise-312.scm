(define (append! x y)
    (set-cdr! (last-pair x) y)
    x)

(define (last-pair x)
    (if (null? (cdr x))
        x
        (last-pair (cdr x))))

(define x (list `a `b))
(define y (list `c `d))

(define z (append x y))
z

(cdr x)
;Value 2: (b)

(define w (append! x y))
w

(cdr x)
;Value 2: (b c d)