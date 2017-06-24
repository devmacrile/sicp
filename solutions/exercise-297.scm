; (a)
(define (max-term-order a b)
    (if (> (order (first-term a)) (order (first-term b)))
        a
        b))

(define (integerizing-factor a b)
    (let ((a1 (first-term a)))
         ((b1 (first-term b)))
         (expt (coeff b1) 
               (+ 1 (- (order a1) 
                       (order b1))))))

(define (reduce-terms n d)
    (let ((g (gcd-terms n d)))
        (let ((factor (integerizing-factor (max-term-order n d) g)))
            (let ((nn (div-terms n g)))
                 ((dd (div-terms d g)))
                (let ((coeff-gcd (gcd (apply gcd (map coeff nn))
                                      (apply gcd (map coeff dd)))))
                    (list (div-terms nn (make-term 0 coeff-gcd))
                          (div-terms dd (make-term 0 coeff-gcd))))))))

(define (reduce-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (let ((var (variable p1))
             ((reduced (reduce-terms (term-list p1) (term-list p2)))))
            (list 
                (make-poly var (car reduced))
                (make-poly var (cadr reduced))))
        (error "Polys not in same var -- DIV-POLY"
               (list p1 p2))))

; (b) 
; create reduce-terms equivalent of reduce-integers
(define (reduce-integers n d)
    (let ((g (gcd n d)))
        (list (/ n g) (/ d g))))

(put `reduce `(scheme-number scheme-number)
    (lambda (n d) (reduce-integers n d)))

(put `reduce `(polynomial polynomial)
    (lambda (n d) (reduce-polynomial n d)))

; Nice - so now we can just call reduce in the original make-rat
; dispatching on type.
(define p1 (make-polynomial `x `((1 1) (0 1))))
(define p2 (make-polynomial `x `((3 1) (0 -1))))
(define p3 (make-polynomial `x `((1 1))))
(define p4 (make-polynomial `x `((2 1) (0 -1))))

(define rf1 (make-rational p1 p2))
(define rf2 (make-rational p3 p4))

(add rf1 rf2)


