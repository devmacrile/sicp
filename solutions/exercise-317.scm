(define (count-pairs x)
    (let ((seen (list)))
        (define (count-pairs-iter x count)
            (cond ((null? x) count)
                ((pair? x)
                    (if (visited? x seen)
                        count
                        (begin (set! seen (append (list x) seen))
                            (count-pairs-iter (cdr x)
                                              (+ count (count-pairs-iter (car x) 1))))))
                (else count)))
        (count-pairs-iter x 0)))


; should use a set, but whatevs
(define (visited? x seen)
    (if (null? seen)
        #f
        (if (eq? (car seen) x)
            #t
            (visited? x (cdr seen)))))


; same examples from last round, should all return 3
(define x (cons `a (cons `b (cons `c `d))))
(count-pairs x)

(define x1 (cons `a `b))
(define x2 (cons x1 `c))
(count-pairs (cons x1 x2))

(define x1 (cons `a `b))
(define x2 (cons x1 x1))
(count-pairs (cons x2 x2))

; should be 5
(count-pairs (cons (cons x1 x2) (cons x1 x1)))