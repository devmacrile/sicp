(define (square-list items)
    (define (iter things answer)
        (if (null? things)
            answer
            (iter (cdr things)
                (cons answer (square (car things))))))
    (iter items `()))

(square-list (list 1 2 3 4 5))

; The nil ends up at the front of the list (but that's a symptom).
; More problematic is that a list isn't returned, but nested conses.