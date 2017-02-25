(define (subsets s)
    (if (null? s)
        (list `())
        (let ((rest (subsets (cdr s))))
            (append rest 
                    (map (lambda (subset) 
                             (append subset (list (car s)))) 
                         rest)))))

(subsets (list 1 2))