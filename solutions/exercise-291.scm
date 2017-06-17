(define (div-terms L1 L2)
    (if (empty-termlist? L1)
        (list (the-empty-termlist) (the-empty-termlist))
        (let ((t1 (first-term L1)))
             ((t2 (first-term L2)))
          (if (> (order t2) (order t1))
            (list (the-empty-termlist) L1)
            (let ((new-c (div (coeff t1) (coeff t2)))
                  (new-o (- (order t1) (order t2))
                  (new-term (make-tern new-o new-c))))
              (let ((new-term (make-term new-o new-c))
                (rest-of-result
                ; compute recursively
                (div-terms (add-terms L1 
                             (negate-terms 
                                (mul-term-by-all-terms 
                                    (make-term new-o new-c)
                                    L2)))
                            L2)))
              ;form complete result
              (cons (adjoin-term new-term 
                                 (car rest-of-result))
                    (cdr rest-of-result))))))))

(define (div-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (let ((div-result 
               (div-terms (term-list p1)
                          (term-list p2))))
          ; list of quotient and remainder
          (list (make-poly (variable p1) (car div-result))
                (make-poly (variable p1) (cdr div-result))))
        (error "Polys not in same var -- DIV-POLY"
               (list p1 p2))))
