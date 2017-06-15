(define (project x)
    (apply-generic `project x))

; install the below in their respective packages
(define (project-complex c)
    (make-real (real-part c)))
(put `project `complex (lambda (c) (project-complex c)))


; had to go to the scheme documentation
; to use some built-ins for this method
; https://www.gnu.org/software/mit-scheme/documentation/mit-scheme-ref/Numerical-operations.html
(define (project-real r)
    (rationalize (inexact->exact r) 1/10))
(put `project `real (lambda (r) (project-real r)))


; round primitive said to be okay
(define (project-rational r)
    (round r))
(put `project `rational (lambda (r) (project-rational r)))

; since we are defining project with apply-generic
(put `project `integer (lambda (i) i))


; utilized generic equality equ? from 2.79
(define (drop num)
    (let ((proj (project num)))
        (if (equ? (raise proj) num)
            (drop proj)
            num)))


; modified apply-generic to use drop
(define (apply-generic op . args)
    (let ((type-tags (map type-tag args)))
        (let ((proc (get op type-tags)))
            (if proc
                (drop (apply proc (map contents args)))
                (if (= (length args) 2)
                    (let ((type1 (car type-tags))
                          (type2 (cadr type-tags))
                          (a1 (car args))
                          (a2 (cadr args)))
                        (if (= type1 type2)
                            (error "No method for -this- type")
                            (if (is-above a1 a2)
                                (apply-generic op a1 (raise a2))
                                (apply-generic op (raise a1) a2))
                            (error "No method for these types"
                                   (list op type-tags)))))))))
