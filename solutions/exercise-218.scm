; Could utilize list-ref
(define (reverse l)
    (define (iter l1 l2)
        (if (null? l1)
            l2
            (iter (cdr l1) (cons (car l1) l2))))
    (iter (cdr l) (cons (car l) `())))

(reverse (list 1 2 3 4 5))