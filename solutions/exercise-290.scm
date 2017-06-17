; Unfinished sketch
; But basically create two distinct packages as
; in section 2.4.3 (on for dense, one for sparse)
; 
; I'm not sure if the idea was to intelligently decide
; which representation to utilize behind the scenes,
; or allow the user to decide their representation with 
; different constructors.

(define (install-sparse-polynomial-package)
    ; internal procedures

    ; interface to rest of system
    (define (tag p) (attach-tag `sparse-polynomial p))
    (put `add `(sparse-polynomial sparse-polynomial)
        (lambda (p1 p2) (tag (add-poly p1 p2))))
    (put `mul `(sparse-polynomial sparse-polynomial)
        (lambda (p1 p2) (tag (mul-poly p1 p2))))
    (put `make `sparse-polynomial
        (lambda (var terms) (tag (make-poly var terms))))
    )


(define (install-dense-polynomial-package)
    ; internal procedures

    ; interface to rest of system
    (define (tag p) (attach-tag `dense-polynomial p))
    (put `add `(dense-polynomial dense-polynomial)
        (lambda (p1 p2) (tag (add-poly p1 p2))))
    (put `mul `(dense-polynomial dense-polynomial)
        (lambda (p1 p2) (tag (mul-poly p1 p2))))
    (put `make `dense-polynomial
        (lambda (var terms) (tag (make-poly var terms))))
    )


