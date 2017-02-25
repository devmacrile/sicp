(define (make-mobile left right)
    (list left right))

(define (make-branch length structure)
    (list length structure))

(define (left-branch x)
    (car x))

(define (right-branch x)
    (car (cdr x)))

(define (branch-length x)
    (car x))

(define (branch-structure x)
    (car (cdr (x))))

(define (total-weight mobile)
    (cond ((null? x) 0)
        ((not (pair? (branch-structure x)) (branch-structure x)))
        (else (+ (total-weight (left-branch mobile)) 
                 (total-weight (right-branch mobile))))))

(define (torque x)
    (* (branch-length x) (total-weight x)))

(define (balanced? x)
    (if (null? x) 
        #t
        (and (balanced? (left-branch x)) 
             (balanced? (right-branch x))
             (= (torque (left-branch x)) (torque (right-branch x))))))

; If changing constructors to the below, how much does above implementation need
; to change?  
; Just the accessor functions for right-branch/branch-structure.
(define (make-mobile left right)
    (cons left right))

(define (make-branch length structure)
    (cons length structure))