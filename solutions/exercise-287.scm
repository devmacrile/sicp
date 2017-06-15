(put `=zero? `polynomial 
    (lambda (p)
        (define (zero-check-iter terms)
            (if (not (empty-termlist? terms))
                (and (=zero? (coeff (first-term)))
                     (zero-check-iter (rest-terms terms)))
                #t)
            (zero-check-iter (term-list p)))))