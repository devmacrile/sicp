; (a)
; basically the same as 4.16
(define (letrec->let exp)
    (let* ((bindings (cadr exp))
           (vars (map car bindings))
           (vals (map cadr bindings))
           (body (cddr exp)))
      (define (unassigned-binding var)
        (list var `*unassigned*`))
      (define (make-binding var val)
        (list `set! var val))
      (append (list `let
                    (map unassigned vars)
                    (map make-binding vars vals)
                    body)))

; (b)
(define (range n)
    (define (range-iter l n)
        (if (= n 0)
            l
            (append (list n) (range-iter l (- n 1)))))
    (range-iter `() n))

(define (f x)
    (let ((even?
               (lambda (n)
                 (if (= n 0)
                    #t
                    (odd? (- n 1)))))
         (odd?
            (lambda (n)
                (if (= n 0)
                    #f
                    (even? (- n 1))))))
     (map new-odd? (range x))))

;(define (f x)
;    ((lambda (even? odd?)
;        (map new-odd? (range x)))
;    (lambda (n)
;      (if (= n 0)
;        #t
;        (odd? (- n 1))))  ; what is odd? here?
;    (lambda (n)
;      (if (= n 0)
;        #f
;        (even? (- n 1)))))) ; what is even? here?

; this actually works fine, however.  why?
(f 5)

; As let is a syntactic lambda with the bindings as arguments,
; the arguments become the lambdas associated in the let bindings;
; so when these are evaluated, they are not within the context of
; the outer lambda, and so are not 'aware' of each other.
