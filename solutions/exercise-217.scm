; Could use list-ref or length, but for purposes of the exercise
(define (last-pair l)
    (if (null? (cdr l))
        (car l)
        (last-pair (cdr l))))

(last-pair (list 23 72 149 34))