(define (same-parity x . y)
    (define (check-parity y)
        (or (and (even? x) (even? y)) (and (not (even? x)) (not (even? y)))))
    (define (iter l1 l2)
        (if (null? l1)
            l2
            (if (check-parity (car l1))
                (iter (cdr l1) (append l2 (list (car l1))))
                (iter (cdr l1) l2))))
    (cons x (iter y `())))

(same-parity 1 2 3 4 5 6 7)
(same-parity 2 3 4 5 6 7)