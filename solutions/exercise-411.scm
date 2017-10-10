; technically can just alter the data abstraction
; procedures, though this might not be the intention?
; but would want to add setters for the procedures
; that update variables/values and use those in 
; set-variable-value! and define-variable!
(define (make-frame variables values)
    (map (lambda (a b) (cons a b)) variables values))

(define (frame-variables frame)
    (map car frame))

(define (frame-values fram)
    (map cdr frame))

(define (add-binding-to-frame! var val frame)
    (set-car! frame (cons (cons var val) frame)))
