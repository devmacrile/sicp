(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

(define (count-leaves-orig x)
    (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))

(define (count-leaves tree)
    (accumulate +
        0
        (map (lambda (x) 
                 (if (pair? x)
                    (count-leaves x)
                    1))
              tree))) 

(count-leaves (list 1 (list (list 2 3) 4) (list 5 (list 6 (list 7 8)))))