(define (make-unbound var env)
    (let ((frame (first-frame env)))
        (define (scan vars vals)
            (cond ((null? vars)
                   `ok)
                   ((eq? var (car vars))
                    (begin
                        (set! vars (cdr vars))
                        (set! vals (cdr vals))))
                   (else (scan (cdr vars) (cdr vals)))))
        (scan (frame-variables frame) 
              (frame-values frame))))

; Unbounding here is limited to the first frame so as to 
; be symmetrical in behavior with define-variable! and because
; it seems most reasonable to only be unbounding variables
; within given scope