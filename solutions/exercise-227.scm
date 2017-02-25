(define (deep-reverse l)
    (define (iter items answer)
        (if (null? items)
            answer
            (if (pair? (car items))
                (iter (cdr items) 
                      (cons (deep-reverse (car items)) answer))
                (iter (cdr items) 
                      (append (list (car items)) answer)))))
    (iter l `()))

(deep-reverse (list 1 3 (list 5 7) 9))